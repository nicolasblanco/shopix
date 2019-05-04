defmodule Shopix.Repo.Migrations.CreateUniqueIndexProductsProperties do
  use Ecto.Migration

  def change do
    create unique_index(:products_properties, [:product_id, :property_id], name: :product_property_index)
  end
end
