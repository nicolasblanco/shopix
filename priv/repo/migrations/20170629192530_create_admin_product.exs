defmodule Shopix.Repo.Migrations.CreateShopix.Admin.Product do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string
      add :price, :decimal, precision: 10, scale: 2
      add :name_translations, :map
      add :description_translations, :map
      add :slug_translations, :map

      timestamps()
    end

  end
end
