defmodule Shopix.Schema.Order do
  use Ecto.Schema
  @timestamps_opts [type: Timex.Ecto.DateTime,
                    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}]

  alias Shopix.Schema.{Order, LineItem}

  schema "orders" do
    has_many :line_items, LineItem, on_replace: :delete

    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :company_name, :string

    field :address_1, :string
    field :address_2, :string
    field :zip_code, :string
    field :city, :string
    field :country_state, :string
    field :country_code, :string
    field :phone, :string

    field :vat_percentage, :decimal

    field :completed_at, Timex.Ecto.DateTime

    field :shipping_cost_amount, Money.Ecto.Type
    field :total_quantity, :integer, virtual: true
    field :price_items, Money.Ecto.Type, virtual: true
    field :total_price, Money.Ecto.Type, virtual: true

    timestamps()
  end

  def compute_properties(%Order{} = order, config \\ %{}) do
    order
    |> compute_line_items
    |> compute_totals(config)
  end

  def compute_line_items(%Order{} = order) do
    %{order | line_items: order.line_items |> Enum.map(&LineItem.compute_properties(&1))}
  end

  def compute_totals(%Order{} = order, config) do
    %{order | total_quantity: total_quantity(order),
              price_items: price_items(order),
              total_price: total_price(order, config)}
  end

  def shipping_cost_amount(%Order{shipping_cost_amount: nil} = order, shipping_cost_default_amount) do
    Shopix.ShippingCostCalculator.shipping_cost_for(order, shipping_cost_default_amount)
  end
  def shipping_cost_amount(%Order{shipping_cost_amount: shipping_cost_amount}, _), do: shipping_cost_amount

  def total_quantity(%Order{} = order) do
    Enum.reduce(order.line_items, 0, fn line_item, acc -> acc + line_item.quantity end)
  end

  def price_items(%Order{} = order) do
    Enum.reduce(order.line_items, Money.new(0), fn line_item, acc -> Money.add(acc, line_item.total_price) end)
  end

  def total_price(%Order{} = order, config) do
    order
    |> price_items()
    |> Money.add(shipping_cost_amount(order, Map.get(config, :shipping_cost_default_amount)))
  end
end
