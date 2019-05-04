defmodule Shopix.Repo.Migrations.CreatePropertiesTable do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :name_translations, :map

      timestamps()
    end
  end
end
