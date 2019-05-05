defmodule Shopix.Admin.GlobalConfig do
  alias Shopix.Schema.GlobalConfig
  import Ecto.Changeset

  def changeset(%GlobalConfig{} = global_config, attrs) do
    global_config
    |> cast(attrs, [
      :name,
      :vat_percentage,
      :shop_opened,
      :default_locale,
      :available_locales,
      :emails_from,
      :default_timezone,
      :shipping_cost_default_amount,
      :upload_provider_public_key
    ])
    |> put_payment_gateway(attrs)
    |> validate_required([
      :name,
      :vat_percentage,
      :default_locale,
      :available_locales,
      :emails_from,
      :default_timezone
    ])
  end

  def put_payment_gateway(changeset, %{"payment_gateway" => payment_gateway_params}) do
    put_change(changeset, :payment_gateway, Poison.decode!(payment_gateway_params))
  end

  def put_payment_gateway(changeset, _), do: changeset
end
