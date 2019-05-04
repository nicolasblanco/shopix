defmodule Shopix.Repo.Migrations.AddPaymentGatewayConfigToGlobalConfig do
  use Ecto.Migration

  def change do
    alter table(:global_config) do
      add :payment_gateway, :map, default: "{}"
    end
  end
end
