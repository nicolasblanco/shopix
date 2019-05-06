defmodule Shopix.Front.Order do
  import Ecto.Changeset

  alias Shopix.Front
  alias Shopix.Schema.{Order, LineItem}

  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [])
    |> cast_assoc(:line_items, with: &Front.LineItem.changeset/2)
  end

  def changeset_address(%Order{} = order, attrs) do
    order
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :company_name,
      :address_1,
      :address_2,
      :zip_code,
      :city,
      :country_state,
      :country_code,
      :phone
    ])
    |> validate_required([
      :email,
      :first_name,
      :last_name,
      :address_1,
      :zip_code,
      :city,
      :country_code,
      :phone
    ])
    |> validate_format(:email, ~r/@/)
  end

  def changeset_payment(%Order{} = order, %{
        vat_percentage: vat_percentage,
        shipping_cost_default_amount: shipping_cost_default_amount
      }) do
    order
    |> change()
    |> put_assoc(:line_items, Enum.map(order.line_items, &LineItem.changeset_cache(&1)))
    |> put_change(:completed_at, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
    |> put_change(
      :shipping_cost_amount,
      Shopix.ShippingCostCalculator.shipping_cost_for(order, shipping_cost_default_amount)
    )
    |> put_change(:vat_percentage, vat_percentage)
  end
end
