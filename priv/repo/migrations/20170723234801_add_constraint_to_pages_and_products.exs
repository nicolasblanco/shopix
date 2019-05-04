defmodule Shopix.Repo.Migrations.AddConstraintToPagesAndProducts do
  use Ecto.Migration

  def change do
    create unique_index(:pages, [:key])
    create unique_index(:products, ["lower(sku)"], name: :products_lower_sku_index)
  end
end
