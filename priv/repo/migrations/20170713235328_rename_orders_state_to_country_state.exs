defmodule Shopix.Repo.Migrations.RenameOrdersStateToCountryState do
  use Ecto.Migration

  def change do
    rename table(:orders), :state, to: :country_state
  end
end
