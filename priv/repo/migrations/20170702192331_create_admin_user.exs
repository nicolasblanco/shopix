defmodule Shopix.Repo.Migrations.CreateShopix.Admin.User do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end
