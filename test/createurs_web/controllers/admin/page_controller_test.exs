defmodule ShopixWeb.Admin.PageControllerTest do
  use ShopixWeb.ConnCase, async: true

  @valid_attrs %{
    key: "faq",
    name_fr: "Foire aux questions",
    name_en: "Frequently asked questions",
    content_fr: "Comment faire ci, faire ça...",
    content_en: "How to do this and that..."
  }
  @update_attrs %{
    key: "new_faq",
    name_fr: "Foire aux nouvelles questions",
    name_en: "Frequently asked new questions",
    content_fr: "Comment faire ci, faire ça, lalala...",
    content_en: "How to do this and that and this again..."
  }
  @invalid_attrs %{"key" => ""}

  test "index/2 responds with the pages" do
    insert(:page, key: "foo-bar")

    conn =
      guardian_login(insert(:user))
      |> get(admin_page_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "foo-bar"
  end

  test "new/2 responds with a form for a new page" do
    conn =
      guardian_login(insert(:user))
      |> get(admin_page_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New page"
  end

  test "create/2 with valid attributes redirects and sets flash" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_page_path(build_conn(), :create), %{"page" => @valid_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid attributes renders form" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_page_path(build_conn(), :create), %{"page" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New page"
  end

  test "edit/2 responds with the edition of the page" do
    page = insert(:page)

    conn =
      guardian_login(insert(:user))
      |> get(admin_page_path(build_conn(), :edit, page.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit page"
  end

  test "update/2 with valid attributes redirects and sets flash" do
    page = insert(:page)

    conn =
      guardian_login(insert(:user))
      |> put(admin_page_path(build_conn(), :update, page.id), %{"page" => @update_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "update/2 with invalid attributes renders form" do
    page = insert(:page)

    conn =
      guardian_login(insert(:user))
      |> put(admin_page_path(build_conn(), :update, page.id), %{"page" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit page"
  end

  test "delete/2 redirects and sets flash" do
    page = insert(:page)

    conn =
      guardian_login(insert(:user))
      |> delete(admin_page_path(build_conn(), :update, page.id))

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end
end
