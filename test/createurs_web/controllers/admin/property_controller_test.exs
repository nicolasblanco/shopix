defmodule ShopixWeb.Admin.PropertyControllerTest do
  use ShopixWeb.ConnCase, async: true

  @valid_attrs %{key: "foo-bar", name_fr: "Hauteur", name_en: "Height"}
  @update_attrs %{key: "new-foo-bar", name_fr: "Longueur", name_en: "Length"}
  @invalid_attrs %{key: ""}

  test "index/2 responds with the propertys" do
    insert(:property, key: "foo-bar")
    conn = guardian_login(insert(:user))
           |> get(admin_property_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "foo-bar"
  end

  test "new/2 responds with a form for a new property" do
    conn = guardian_login(insert(:user))
           |> get(admin_property_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New property"
  end

  test "create/2 with valid attributes redirects and sets flash" do
    conn = guardian_login(insert(:user))
           |> post(admin_property_path(build_conn(), :create), %{"property" => @valid_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid attributes renders form" do
    conn = guardian_login(insert(:user))
           |> post(admin_property_path(build_conn(), :create), %{"property" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New property"
  end

  test "edit/2 responds with the edition of the property" do
    property = insert(:property)
    conn = guardian_login(insert(:user))
           |> get(admin_property_path(build_conn(), :edit, property.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit property"
  end

  test "update/2 with valid attributes redirects and sets flash" do
    property = insert(:property)
    conn = guardian_login(insert(:user))
           |> put(admin_property_path(build_conn(), :update, property.id), %{"property" => @update_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "update/2 with invalid attributes renders form" do
    property = insert(:property)
    conn = guardian_login(insert(:user))
           |> put(admin_property_path(build_conn(), :update, property.id), %{"property" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit property"
  end

  test "delete/2 redirects and sets flash" do
    property = insert(:property)
    conn = guardian_login(insert(:user))
           |> delete(admin_property_path(build_conn(), :update, property.id))

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end
end
