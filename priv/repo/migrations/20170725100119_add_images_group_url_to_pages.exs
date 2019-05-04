defmodule Shopix.Repo.Migrations.AddImagesGroupUrlToPages do
  use Ecto.Migration

  def change do
    alter table(:pages) do
      add :images_group_url, :string
    end
  end
end
