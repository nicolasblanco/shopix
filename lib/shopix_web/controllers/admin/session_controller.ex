defmodule ShopixWeb.Admin.SessionController do
  use ShopixWeb, :controller
  plug :put_layout, "basic.html"

  alias Shopix.{Admin, Guardian}

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"credentials" => credentials_params}) do
    case Admin.find_and_confirm_password(credentials_params) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user, %{}, key: :admin)
        |> put_flash(:info, "Logged in successfully.")
        |> redirect(to: "/admin")

      {:error, _} ->
        render(conn, "new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out(key: :admin)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required.")
    |> redirect(to: admin_session_path(conn, :new))
  end
end
