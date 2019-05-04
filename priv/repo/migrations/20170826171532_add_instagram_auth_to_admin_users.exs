defmodule Shopix.Repo.Migrations.AddInstagramAuthToAdminUsers do
  use Ecto.Migration

  def change do
    alter table(:admin_users) do
      add :instagram_auth, :map, default: "{}"
    end
  end
end
