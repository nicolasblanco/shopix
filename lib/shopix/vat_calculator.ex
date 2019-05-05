defmodule Shopix.VatCalculator do
  def ati_to_et(vat_percentage, amount) when is_integer(amount) do
    divider =
      vat_percentage
      |> Decimal.div(Decimal.new(100))
      |> Decimal.add(Decimal.new(1))

    result =
      Decimal.new(amount)
      |> Decimal.div(divider)

    result
    |> Decimal.round()
    |> Decimal.to_integer()
  end

  def vat_amount(vat_percentage, amount) when is_integer(amount) do
    amount - ati_to_et(vat_percentage, amount)
  end
end
