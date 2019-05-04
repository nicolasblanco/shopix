defmodule Shopix.Admin.AdminPageTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.Page

  @valid_attrs %{key: "faq",
                  name_translations: %{"fr" => "Foire aux questions",
                                      "en" => "Frequently asked questions"},
                  content_translations: %{"fr" => "Comment faire ci, faire ça...",
                                          "en" => "How to do this and that..."}
                }
  @update_attrs %{key: "new_faq",
                  name_translations: %{"fr" => "Foire aux nouvelles questions",
                                      "en" => "Frequently asked new questions"},
                  content_translations: %{"fr" => "Comment faire ci, faire ça, lalala...",
                                          "en" => "How to do this and that and this again..."}
                }
  @invalid_attrs %{key: ""}

  test "list_pages/1 returns all pages paginated" do
    page = insert(:page)
    assert %{entries: pages} = Admin.list_pages(%{})
    assert pages == [page]
  end

  test "get_page!/1 returns the page with given id" do
    page = insert(:page)
    assert Admin.get_page!(page.id) == page
  end

  test "create_page/1 with valid data creates a page" do
    assert {:ok, %Page{} = page} = Admin.create_page(@valid_attrs)
    assert page.key == "faq"
    assert page.name_translations["fr"] == "Foire aux questions"
    assert page.name_translations["en"] == "Frequently asked questions"
    assert page.content_translations["fr"] == "Comment faire ci, faire ça..."
    assert page.content_translations["en"] == "How to do this and that..."
    assert page.slug_translations["fr"] == "foire-aux-questions"
    assert page.slug_translations["en"] == "frequently-asked-questions"
  end

  test "create_page/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Admin.create_page(@invalid_attrs)
  end

  test "update_page/2 with valid data updates the page" do
    page = insert(:page)

    assert {:ok, page} = Admin.update_page(page, @update_attrs)
    assert %Page{} = page
    assert page.key == "new_faq"
    assert page.name_translations["fr"] == "Foire aux nouvelles questions"
    assert page.name_translations["en"] == "Frequently asked new questions"
    assert page.content_translations["fr"] == "Comment faire ci, faire ça, lalala..."
    assert page.content_translations["en"] == "How to do this and that and this again..."
    assert page.slug_translations["fr"] == "foire-aux-nouvelles-questions"
    assert page.slug_translations["en"] == "frequently-asked-new-questions"
  end

  test "update_page/2 with invalid data returns error changeset" do
    page = insert(:page)
    assert {:error, %Ecto.Changeset{}} = Admin.update_page(page, @invalid_attrs)

    assert Admin.get_page!(page.id) == page
  end

  test "delete_page/1 deletes the page" do
    page = insert(:page)

    assert {:ok, %Page{}} = Admin.delete_page(page)
    assert_raise Ecto.NoResultsError, fn -> Admin.get_page!(page.id) end
  end

  test "change_page/1 returns a page changeset" do
    page = insert(:page)
    assert %Ecto.Changeset{} = Admin.change_page(page)
  end
end
