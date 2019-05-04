defmodule Shopix.Repo.Migrations.AlterProductsPriceToInteger do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :price, :integer
    end
  end
end
