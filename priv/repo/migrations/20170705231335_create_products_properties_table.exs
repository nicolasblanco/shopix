defmodule Shopix.Repo.Migrations.CreateProductsPropertiesTable do
  use Ecto.Migration

  def change do
    create table(:products_properties) do
      add :property_id, references(:properties)
      add :product_id, references(:products)

      add :value_translations, :map

      timestamps()
    end
  end
end
