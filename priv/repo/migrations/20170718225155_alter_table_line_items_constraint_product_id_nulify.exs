defmodule Shopix.Repo.Migrations.AlterTableLineItemsConstraintProductIdNulify do
  use Ecto.Migration

  def change do
    drop constraint(:line_items, "line_items_product_id_fkey")

    alter table(:line_items) do
      modify :product_id, references(:products, on_delete: :nilify_all)
    end
  end
end
