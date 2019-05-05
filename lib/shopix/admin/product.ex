defmodule Shopix.Admin.Product do
  import Ecto.{Changeset, Query}
  use Shopix.TranslationFields, slug: :name, translated_fields: ~w(name description slug)

  alias Shopix.Repo
  alias Shopix.Schema.{Product, Group}

  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:sku, :price, :images_group_url, :displayed] ++ localized_fields())
    |> cast_assoc(:product_properties, with: &Shopix.Admin.ProductProperty.changeset/2)
    |> change_slugs()
    |> validate_required([:sku, :price])
    |> update_groups(attrs)
    |> unique_constraint(:sku, name: :products_lower_sku_index)
  end

  def update_groups(changeset, %{"group_ids" => ""}), do: put_assoc(changeset, :groups, [])

  def update_groups(changeset, %{"group_ids" => group_ids}) do
    groups = Repo.all(from g in Group, where: g.id in ^group_ids)
    put_assoc(changeset, :groups, groups)
  end

  def update_groups(changeset, _), do: changeset
end
