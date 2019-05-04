defmodule Shopix.Repo.Migrations.AddUniqueIndexesUsersTranslations do
  use Ecto.Migration

  def change do
    create unique_index(:admin_users, [:email])
    create unique_index(:translations, [:key, :locale], name: :translations_key_locale)
    create unique_index(:properties, [:key])
  end
end
