defmodule Shopix.Repo.Migrations.AlterOrdersAddShippingCostColumn do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :shipping_cost_amount, :integer
    end
  end
end
