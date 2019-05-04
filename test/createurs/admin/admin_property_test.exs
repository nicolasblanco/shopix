defmodule Shopix.Admin.AdminPropertyTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.Property

  @valid_attrs %{key: "foo-bar", name_translations: %{"fr" => "Hauteur", "en" => "Height"}}
  @update_attrs %{key: "new-foo-bar", name_translations: %{"fr" => "Longueur", "en" => "Length"}}
  @invalid_attrs %{key: ""}

  test "list_properties/0 returns all properties" do
    property = insert(:property)
    properties = Admin.list_properties()
    assert properties == [property]
  end

  test "list_properties/1 returns all properties paginated" do
    property = insert(:property)
    assert %{entries: properties} = Admin.list_properties(%{})
    assert properties == [property]
  end

  test "get_property!/1 returns the property with given id" do
    property = insert(:property)
    assert Admin.get_property!(property.id) == property
  end

  test "create_property/1 with valid data creates a property" do
    assert {:ok, %Property{} = property} = Admin.create_property(@valid_attrs)
    assert property.key == "foo-bar"
    assert property.name_translations["fr"] == "Hauteur"
    assert property.name_translations["en"] == "Height"
  end

  test "create_property/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Admin.create_property(@invalid_attrs)
  end

  test "update_property/2 with valid data updates the property" do
    property = insert(:property)

    assert {:ok, property} = Admin.update_property(property, @update_attrs)
    assert %Property{} = property
    assert property.key == "new-foo-bar"
    assert property.name_translations["fr"] == "Longueur"
    assert property.name_translations["en"] == "Length"
  end

  test "update_property/2 with invalid data returns error changeset" do
    property = insert(:property)
    assert {:error, %Ecto.Changeset{}} = Admin.update_property(property, @invalid_attrs)

    assert Admin.get_property!(property.id) == property
  end

  test "delete_property/1 deletes the property" do
    property = insert(:property)

    assert {:ok, %Property{}} = Admin.delete_property(property)
    assert_raise Ecto.NoResultsError, fn -> Admin.get_property!(property.id) end
  end

  test "change_property/1 returns a property changeset" do
    property = insert(:property)
    assert %Ecto.Changeset{} = Admin.change_property(property)
  end
end
