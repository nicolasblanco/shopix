defmodule Shopix.Schema.GlobalConfig do
  use Ecto.Schema

  schema "global_config" do
    field :name, :string, default: "My shop"
    field :vat_percentage, :decimal, default: Decimal.new(20)
    field :shop_opened, :boolean, default: true
    field :default_locale, :string, default: "en"
    field :available_locales, {:array, :string}, default: ["en"]
    field :emails_from, :string, default: "admin@example.com"
    field :default_timezone, :string, default: "Europe/Paris"
    field :payment_gateway, :map, default: %{}
    field :shipping_cost_default_amount, :integer, default: 0
    field :upload_provider_public_key, :string
  end
end
