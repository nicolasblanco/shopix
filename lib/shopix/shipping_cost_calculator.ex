defmodule Shopix.ShippingCostCalculator do
  alias Shopix.Schema.Order

  def shipping_cost_amount(shipping_cost_default_amount) do
    Money.new(shipping_cost_default_amount)
  end

  def shipping_cost_for(%Order{} = _order, shipping_cost_default_amount),
    do: shipping_cost_amount(shipping_cost_default_amount)
end
