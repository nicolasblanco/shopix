defmodule ShopixWeb.Admin.TranslationControllerTest do
  use ShopixWeb.ConnCase, async: true

  @valid_attrs %{key: "foo_bar", value_fr: "Bonjour", value_en: "Hello"}
  @update_attrs %{key: "new_foo_bar", value_fr: "Salut", value_en: "Hi"}
  @invalid_attrs %{key: ""}

  test "index/2 responds with the translations" do
    insert(:translation, key: "foo-bar")

    conn =
      guardian_login(insert(:user))
      |> get(admin_translation_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "foo-bar"
  end

  test "new/2 responds with a form for a new translation" do
    conn =
      guardian_login(insert(:user))
      |> get(admin_translation_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New translation"
  end

  test "create/2 with valid attributes redirects and sets flash" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_translation_path(build_conn(), :create), %{"translation" => @valid_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid attributes renders form" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_translation_path(build_conn(), :create), %{"translation" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New translation"
  end

  test "edit/2 responds with the edition of the translation" do
    translation = insert(:translation)

    conn =
      guardian_login(insert(:user))
      |> get(admin_translation_path(build_conn(), :edit, translation.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit translation"
  end

  test "update/2 with valid attributes redirects and sets flash" do
    translation = insert(:translation)

    conn =
      guardian_login(insert(:user))
      |> put(admin_translation_path(build_conn(), :update, translation.id), %{
        "translation" => @update_attrs
      })

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "update/2 with invalid attributes renders form" do
    translation = insert(:translation)

    conn =
      guardian_login(insert(:user))
      |> put(admin_translation_path(build_conn(), :update, translation.id), %{
        "translation" => @invalid_attrs
      })

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit translation"
  end

  test "delete/2 redirects and sets flash" do
    translation = insert(:translation)

    conn =
      guardian_login(insert(:user))
      |> delete(admin_translation_path(build_conn(), :update, translation.id))

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end
end
