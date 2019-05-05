defmodule Shopix.Schema.LineItem do
  use Ecto.Schema

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  import Ecto.Changeset

  alias Shopix.Schema.{LineItem, Order, Product}

  schema "line_items" do
    belongs_to :order, Order
    belongs_to :product, Product

    field :quantity, :integer, default: 1
    field :product_price_cache, Money.Ecto.Type
    field :product_sku_cache, :string

    field :product_price, Money.Ecto.Type, virtual: true
    field :product_sku, :string, virtual: true
    field :total_price, Money.Ecto.Type, virtual: true

    timestamps()
  end

  def changeset_cache(%LineItem{} = line_item) do
    line_item
    |> change()
    |> put_change(:product_price_cache, line_item.product.price)
    |> put_change(:product_sku_cache, line_item.product.sku)
  end

  def compute_properties(%LineItem{} = line_item) do
    %{
      line_item
      | total_price: total_price(line_item),
        product_price: product_price(line_item),
        product_sku: product_sku(line_item)
    }
  end

  def increase_quantity(line_item) do
    line_item |> change(quantity: line_item.quantity + 1)
  end

  def decrease_quantity(line_item) do
    line_item |> change(quantity: line_item.quantity - 1)
  end

  def product_price(%LineItem{product_price_cache: nil} = line_item), do: line_item.product.price
  def product_price(%LineItem{product_price_cache: product_price_cache}), do: product_price_cache

  def product_sku(%LineItem{product_sku_cache: nil} = line_item), do: line_item.product.sku
  def product_sku(%LineItem{product_sku_cache: product_sku_cache}), do: product_sku_cache

  def total_price(%LineItem{} = line_item) do
    line_item
    |> product_price
    |> Money.multiply(line_item.quantity)
  end
end
