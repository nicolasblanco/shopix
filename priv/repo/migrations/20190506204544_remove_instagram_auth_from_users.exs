defmodule Shopix.Repo.Migrations.RemoveInstagramAuthFromUsers do
  use Ecto.Migration

  def change do
    alter table(:admin_users) do
      remove :instagram_auth
    end
  end
end
