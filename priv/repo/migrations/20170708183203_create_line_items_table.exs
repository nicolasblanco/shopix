defmodule Shopix.Repo.Migrations.CreateLineItemsTable do
  use Ecto.Migration

  def change do
    create table(:line_items) do
      add :order_id, references(:orders)
      add :product_id, references(:products)

      add :quantity, :integer

      timestamps()
    end
  end
end
