defmodule Shopix.Repo.Migrations.AddsEditHtmlOnlyToPages do
  use Ecto.Migration

  def change do
    alter table(:pages) do
      add :edit_html_only, :boolean, default: false
    end
  end
end
