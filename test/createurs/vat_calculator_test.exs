defmodule Shopix.VatCalculatorTest do
  use ExUnit.Case, async: true
  alias Shopix.VatCalculator

  describe "ati_to_et/1" do
    test "takes a All Tax Included price and returns an Excluded Taxes price as integer" do
      assert VatCalculator.ati_to_et(Decimal.new(20.0), 10000) == 8333
    end
  end
end
