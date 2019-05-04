defmodule ShopixWeb.Admin.SessionControllerTest do
  use ShopixWeb.ConnCase, async: true

  test "new/2 renders login form" do
    conn = build_conn()
           |> get(admin_session_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Sign In"
  end

  test "create/2 with valid credentials redirects and sets flash" do
    user = insert(:user)
    conn = build_conn()
           |> post(admin_session_path(build_conn(), :create),
                   %{"credentials" => %{"email" => user.email, "password" => "test1234"}})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid credentials renders the form" do
    user = insert(:user)
    conn = build_conn()
           |> post(admin_session_path(build_conn(), :create),
                   %{"credentials" => %{"email" => user.email, "password" => "bad_password"}})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Sign In"
  end

  test "delete/2 redirects and sets flash" do
    conn = guardian_login(insert(:user))
           |> get(admin_session_path(build_conn(), :delete))
    
    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "unauthenticated/2 redirects and sets flash" do
    conn = build_conn()
           |> get(admin_home_path(build_conn(), :index))
    
    assert html_response(conn, 302)
    assert get_flash(conn, :error) =~ "required"
  end
end
