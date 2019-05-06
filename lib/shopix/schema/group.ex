defmodule Shopix.Schema.Group do
  use Ecto.Schema
  alias Shopix.Schema.Product

  schema "groups" do
    field :key, :string
    many_to_many :products, Product, join_through: "products_groups"

    timestamps()
  end
end
