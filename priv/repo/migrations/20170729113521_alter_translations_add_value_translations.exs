defmodule Shopix.Repo.Migrations.AlterTranslationsAddValueTranslations do
  use Ecto.Migration

  def change do
    alter table(:translations) do
      add :value_translations, :map
    end
  end
end
