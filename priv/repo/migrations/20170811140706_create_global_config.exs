defmodule Shopix.Repo.Migrations.CreateGlobalConfig do
  use Ecto.Migration

  def change do
    create table(:global_config) do
      add :name, :string
      add :vat_percentage, :decimal, precision: 10, scale: 2
      add :shop_opened, :boolean
      add :default_locale, :string
      add :available_locales, {:array, :string}
      add :emails_from, :string
      add :default_timezone, :string
    end
  end
end
