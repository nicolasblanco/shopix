defmodule Shopix.Repo.Migrations.AddVatPercentageToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :vat_percentage, :decimal, precision: 10, scale: 2
    end
  end
end
