defmodule Shopix.Repo.Migrations.AlterTablesOrdersLineItems do
  use Ecto.Migration

  def change do
    drop constraint(:line_items, "line_items_order_id_fkey")

    alter table(:line_items) do
      modify :order_id, references(:orders, on_delete: :delete_all)

      add :product_price_cache, :integer
      add :product_name_cache, :string
    end
  end
end
