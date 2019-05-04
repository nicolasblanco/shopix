defmodule Shopix.Front.LineItem do
  import Ecto.Changeset

  alias Shopix.Schema.LineItem

  def changeset(%LineItem{} = line_item, attrs) do
    line_item
    |> cast(attrs, [:quantity, :product_id])
    |> validate_required([:quantity, :product_id])
  end
end
