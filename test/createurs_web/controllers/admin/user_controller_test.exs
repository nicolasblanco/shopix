defmodule ShopixWeb.Admin.UserControllerTest do
  use ShopixWeb.ConnCase, async: true

  @valid_attrs %{email: "user@foo.bar", password: "test123"}
  @update_attrs %{email: "super_user@foo.bar", password: "test321"}
  @invalid_attrs %{email: nil, password: nil}

  test "index/2 responds with the users" do
    insert(:user, email: "nicolas@nicolasblanco.fr")

    conn =
      guardian_login(insert(:user))
      |> get(admin_user_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "nicolas@nicolasblanco.fr"
  end

  test "new/2 responds with a form for a new user" do
    conn =
      guardian_login(insert(:user))
      |> get(admin_user_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New administration user"
  end

  test "create/2 with valid attributes redirects and sets flash" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_user_path(build_conn(), :create), %{"user" => @valid_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid attributes renders form" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_user_path(build_conn(), :create), %{"user" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New administration user"
  end

  test "edit/2 responds with the edition of the user" do
    user = insert(:user)

    conn =
      guardian_login(insert(:user))
      |> get(admin_user_path(build_conn(), :edit, user.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit administration user"
  end

  test "update/2 with valid attributes redirects and sets flash" do
    user = insert(:user)

    conn =
      guardian_login(insert(:user))
      |> put(admin_user_path(build_conn(), :update, user.id), %{"user" => @update_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "update/2 with invalid attributes renders form" do
    user = insert(:user)

    conn =
      guardian_login(insert(:user))
      |> put(admin_user_path(build_conn(), :update, user.id), %{"user" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit administration user"
  end

  test "delete/2 redirects and sets flash" do
    user = insert(:user)

    conn =
      guardian_login(insert(:user))
      |> delete(admin_user_path(build_conn(), :update, user.id))

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end
end
