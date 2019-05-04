defmodule Shopix.Repo.Migrations.AddKeyToProperties do
  use Ecto.Migration

  def change do
    alter table(:properties) do
      add :key, :string
    end
  end
end
