defmodule Shopix.Repo.Migrations.AddFieldsToGlobalConfig do
  use Ecto.Migration

  def change do
    alter table(:global_config) do
      add :shipping_cost_default_amount, :integer, default: 0
      add :upload_provider_public_key, :string
    end
  end
end
