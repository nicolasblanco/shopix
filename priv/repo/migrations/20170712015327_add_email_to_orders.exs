defmodule Shopix.Repo.Migrations.AddEmailToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :email, :string
    end
  end
end
