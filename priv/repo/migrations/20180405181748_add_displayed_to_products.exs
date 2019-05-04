defmodule Shopix.Repo.Migrations.AddDisplayedToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :displayed, :boolean, default: true
    end
  end
end
