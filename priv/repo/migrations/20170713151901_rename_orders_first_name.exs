defmodule Shopix.Repo.Migrations.RenameOrdersFirstName do
  use Ecto.Migration

  def change do
    rename table(:orders), :fist_name, to: :first_name
  end
end
