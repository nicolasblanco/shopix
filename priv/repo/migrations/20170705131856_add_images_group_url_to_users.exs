defmodule Shopix.Repo.Migrations.AddImagesGroupUrlToUsers do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :images_group_url, :string
    end
  end
end
