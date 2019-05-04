defmodule Shopix.ShippingCostCalculatorTest do
  use ExUnit.Case, async: true
  alias Shopix.ShippingCostCalculator
  alias Shopix.Schema.Order

  describe "shipping_cost_amount/0" do
    test "returns a Money struct" do
      assert %Money{} = ShippingCostCalculator.shipping_cost_amount(10)
    end
  end

  describe "shipping_cost_for/1" do
    test "returns the shipping cost for a given order" do
      assert %Money{} = ShippingCostCalculator.shipping_cost_for(%Order{}, 10)
    end
  end
end
