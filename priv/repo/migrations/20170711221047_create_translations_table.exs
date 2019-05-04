defmodule Shopix.Repo.Migrations.CreateTranslationsTable do
  use Ecto.Migration

  def change do
    create table(:translations) do
      add :locale, :string
      add :key, :string

      add :value, :text

      timestamps()
    end
  end
end
