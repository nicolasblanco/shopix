defmodule Shopix.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :fist_name, :string
      add :last_name, :string
      add :company_name, :string

      add :address_1, :string
      add :address_2, :string
      add :zip_code, :string
      add :city, :string
      add :state, :string
      add :country_code, :string

      add :phone, :string

      add :checkout_begun_at, :naive_datetime

      timestamps()
    end
  end
end
