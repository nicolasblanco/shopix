defmodule ShopixWeb.AuthErrorHandler do
  import Phoenix.Controller
  alias ShopixWeb.Router.Helpers, as: Routes

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: Routes.admin_session_path(conn, :new))
  end
end
