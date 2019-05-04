defmodule Shopix.Repo.Migrations.AlterProductPropertiesReferences do
  use Ecto.Migration

  def change do
    drop constraint(:products_properties, "products_properties_property_id_fkey")
    drop constraint(:products_properties, "products_properties_product_id_fkey")

    alter table(:products_properties) do
      modify :property_id, references(:properties, on_delete: :delete_all)
      modify :product_id, references(:products, on_delete: :delete_all)
    end
  end
end
