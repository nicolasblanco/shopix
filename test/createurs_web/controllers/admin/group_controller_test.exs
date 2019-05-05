defmodule ShopixWeb.Admin.GroupControllerTest do
  use ShopixWeb.ConnCase, async: true

  @valid_attrs %{key: "yay"}
  @update_attrs %{key: "yay-2"}
  @invalid_attrs %{key: nil}

  test "index/2 responds with the groups" do
    insert(:group, key: "foo-bar")

    conn =
      guardian_login(insert(:user))
      |> get(admin_group_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "foo-bar"
  end

  test "new/2 responds with a form for a new group" do
    conn =
      guardian_login(insert(:user))
      |> get(admin_group_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New group"
  end

  test "create/2 with valid attributes redirects and sets flash" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_group_path(build_conn(), :create), %{"group" => @valid_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid attributes renders form" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_group_path(build_conn(), :create), %{"group" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New group"
  end

  test "edit/2 responds with the edition of the group" do
    group = insert(:group)

    conn =
      guardian_login(insert(:user))
      |> get(admin_group_path(build_conn(), :edit, group.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit group"
  end

  test "update/2 with valid attributes redirects and sets flash" do
    group = insert(:group)

    conn =
      guardian_login(insert(:user))
      |> put(admin_group_path(build_conn(), :update, group.id), %{"group" => @update_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "update/2 with invalid attributes renders form" do
    group = insert(:group)

    conn =
      guardian_login(insert(:user))
      |> put(admin_group_path(build_conn(), :update, group.id), %{"group" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit group"
  end

  test "delete/2 redirects and sets flash" do
    group = insert(:group)

    conn =
      guardian_login(insert(:user))
      |> delete(admin_group_path(build_conn(), :update, group.id))

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end
end
