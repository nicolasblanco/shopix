defmodule Shopix.Repo.Migrations.OrdersAddCompletedAt do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :completed_at, :naive_datetime
      remove :checkout_begun_at
    end
  end
end
