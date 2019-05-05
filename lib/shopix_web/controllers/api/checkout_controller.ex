defmodule ShopixWeb.Api.CheckoutController do
  use ShopixWeb, :controller

  alias Ecto.Changeset
  alias Shopix.{Front, Mailer}
  alias ShopixWeb.Email

  plug(ShopixWeb.Plug.Translations)

  def validate_payment(conn, %{
        "nonce" => payment_nonce,
        "order_id" => order_id,
        "order" => order_params
      }) do
    order = Front.get_order(order_id, conn.assigns.global_config)

    order_params = order_params |> Map.put_new("country_code", "FR")

    case Front.order_validate_address(order, order_params) do
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render("error.json", changeset: changeset)

      {:ok, _} ->
        amount =
          order.total_price
          |> Money.to_string(separator: "", delimeter: ".", symbol_space: false, symbol: false)

        result =
          Braintree.Transaction.sale(
            %{
              amount: amount,
              payment_method_nonce: payment_nonce,
              options: %{
                submit_for_settlement: true
              }
            },
            braintree_options(conn.assigns.global_config)
          )

        with {:ok, _} <- result,
             {:ok, _order} <- Front.order_validate_payment(order, conn.assigns.global_config) do
          order = Front.get_order(order_id, conn.assigns.global_config)

          Email.order_complete_email(
            order,
            conn.assigns.current_locale,
            conn.assigns.global_config
          )
          |> Mailer.deliver_later()

          conn
          |> render("show.json", order: order, locale: conn.assigns.current_locale)
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
  end

  defp braintree_options(global_config) do
    [
      environment:
        global_config.payment_gateway["provider_config"]["environment"] |> String.to_atom(),
      merchant_id: global_config.payment_gateway["provider_config"]["merchant_id"],
      public_key: global_config.payment_gateway["provider_config"]["public_key"],
      private_key: global_config.payment_gateway["provider_config"]["private_key"]
    ]
  end

  def complete(conn, _params) do
    render(conn, "complete.html")
  end
end
