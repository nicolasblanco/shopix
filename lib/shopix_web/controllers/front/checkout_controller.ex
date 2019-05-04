defmodule ShopixWeb.Front.CheckoutController do
  use ShopixWeb, :controller
  alias Shopix.Schema.Order
  alias Ecto.Changeset
  alias Shopix.{Front, Mailer}
  alias ShopixWeb.Email

  plug ShopixWeb.Plug.Translations

  def address(conn, _params) do
    render conn, "address.html", changeset: Front.change_order(conn.assigns.current_order),
                                 countries: Shopix.LocalizedCountries.countries(conn.assigns.current_locale)
  end

  def validate_address(conn, %{"order" => order_params}) do
    case Front.order_validate_address(conn.assigns.current_order, order_params) do
      {:ok, _} ->
        conn |> redirect(to: checkout_path(conn, :payment, conn.assigns.current_locale))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "address.html", changeset: changeset,
                                     countries: Shopix.LocalizedCountries.countries(conn.assigns.current_locale)
    end
  end

  def payment(conn, _params) do
    render conn, "payment.html", shipping_cost_amount: Order.shipping_cost_amount(conn.assigns.current_order, conn.assigns.global_config.shipping_cost_default_amount)
  end

  def validate_payment(conn, %{"payment" => %{"nonce" => payment_nonce}}) do
    order = conn.assigns.current_order

    amount = order.total_price
    |> Money.to_string(separator: "", delimeter: ".", symbol_space: false, symbol: false)

    result = Braintree.Transaction.sale(%{
      amount: amount,
      payment_method_nonce: payment_nonce,
      options: %{
        submit_for_settlement: true
      }
    }, braintree_options(conn.assigns.global_config))

    with {:ok, _} <- result,
         {:ok, order} <- Front.order_validate_payment(order, conn.assigns.global_config) do
      Email.order_complete_email(order, conn.assigns.current_locale, conn.assigns.global_config) |> Mailer.deliver_later()

      conn
      |> clear_session()
      |> redirect(to: checkout_path(conn, :complete, conn.assigns.current_locale))
    else
      {:error, %Changeset{}} ->
        conn
        |> put_flash(:error, "Error when saving the order.")
        |> redirect(to: checkout_path(conn, :payment, conn.assigns.current_locale))
      {:error, %Braintree.ErrorResponse{} = error} ->
        conn
        |> put_flash(:error, "Payment error: #{error.message}")
        |> redirect(to: checkout_path(conn, :payment, conn.assigns.current_locale))
    end
  end

  defp braintree_options(global_config) do
    [
      environment: global_config.payment_gateway["provider_config"]["environment"] |> String.to_atom(),
      merchant_id: global_config.payment_gateway["provider_config"]["merchant_id"],
      public_key:  global_config.payment_gateway["provider_config"]["public_key"],
      private_key: global_config.payment_gateway["provider_config"]["private_key"]
    ]
  end

  def complete(conn, _params) do
    render conn, "complete.html"
  end
end
