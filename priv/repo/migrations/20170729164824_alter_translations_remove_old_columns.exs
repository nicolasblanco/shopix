defmodule Shopix.Repo.Migrations.AlterTranslationsRemoveOldColumns do
  use Ecto.Migration

  def change do
    drop unique_index(:translations, [:key, :locale], name: :translations_key_locale)
    create unique_index(:translations, [:key])

    alter table(:translations) do
      remove :locale
      remove :value
    end
  end
end
