defmodule Shopix.Admin.AdminTranslationTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.Translation

  @valid_attrs %{key: "foo_bar", value_translations: %{"fr" => "Bonjour", "en" => "Hello"}}
  @update_attrs %{key: "new_foo_bar", value_translations: %{"fr" => "Salut", "en" => "Hi"}}
  @invalid_attrs %{key: ""}

  test "list_translations/1 returns all translations paginated" do
    translation = insert(:translation)
    assert %{entries: translations} = Admin.list_translations(%{})
    assert translations == [translation]
  end

  test "get_translation!/1 returns the translation with given id" do
    translation = insert(:translation)
    assert Admin.get_translation!(translation.id) == translation
  end

  test "create_translation/1 with valid data creates a translation" do
    assert {:ok, %Translation{} = translation} = Admin.create_translation(@valid_attrs)
    assert translation.key == "foo_bar"
    assert translation.value_translations["en"] == "Hello"
    assert translation.value_translations["fr"] == "Bonjour"
  end

  test "create_translation/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Admin.create_translation(@invalid_attrs)
  end

  test "update_translation/2 with valid data updates the translation" do
    translation = insert(:translation)

    assert {:ok, translation} = Admin.update_translation(translation, @update_attrs)
    assert %Translation{} = translation
    assert translation.key == "new_foo_bar"
    assert translation.value_translations["en"] == "Hi"
    assert translation.value_translations["fr"] == "Salut"
  end

  test "update_translation/2 with invalid data returns error changeset" do
    translation = insert(:translation)
    assert {:error, %Ecto.Changeset{}} = Admin.update_translation(translation, @invalid_attrs)

    assert Admin.get_translation!(translation.id) == translation
  end

  test "delete_translation/1 deletes the translation" do
    translation = insert(:translation)

    assert {:ok, %Translation{}} = Admin.delete_translation(translation)
    assert_raise Ecto.NoResultsError, fn -> Admin.get_translation!(translation.id) end
  end

  test "change_translation/1 returns a translation changeset" do
    translation = insert(:translation)
    assert %Ecto.Changeset{} = Admin.change_translation(translation)
  end
end
