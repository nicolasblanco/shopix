defmodule Shopix.Repo.Migrations.CreatePagesTable do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :key, :string

      add :name_translations, :map
      add :content_translations, :map
      add :slug_translations, :map

      timestamps()
    end
  end
end
