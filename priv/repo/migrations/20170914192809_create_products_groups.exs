defmodule Shopix.Repo.Migrations.CreateProductsGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :key, :string

      timestamps()
    end

    create table(:products_groups) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :group_id, references(:groups, on_delete: :delete_all)
    end

    create unique_index(:groups, [:key])
  end
end
