defmodule ShopixWeb.Admin.ProductView do
  use ShopixWeb, :view

  def many_association_to_json(data, fields_to_take) do
    map =
      if Ecto.assoc_loaded?(data) do
        data |> Enum.map(&Map.take(&1, fields_to_take))
      else
        []
      end

    Jason.encode!(map)
  end

  def many_to_json(data, fields_to_take) do
    map = data |> Enum.map(&Map.take(&1, fields_to_take))

    Jason.encode!(map)
  end
end
