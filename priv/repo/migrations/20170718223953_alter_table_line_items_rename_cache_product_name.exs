defmodule Shopix.Repo.Migrations.AlterTableLineItemsRenameCacheProductName do
  use Ecto.Migration

  def change do
    rename table(:line_items), :product_name_cache, to: :product_sku_cache
  end
end
