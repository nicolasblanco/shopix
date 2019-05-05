defmodule ShopixWeb.Admin.GlobalConfigController do
  use ShopixWeb, :controller

  alias Shopix.Admin
  alias Ecto.Changeset

  def show(conn, _params) do
    changeset = Admin.change_global_config(conn.assigns.global_config)

    render(conn, "show.html",
      global_config: conn.assigns.global_config,
      changeset: changeset
    )
  end

  def update(conn, %{"global_config" => global_config_params}) do
    case Admin.update_global_config(conn.assigns.global_config, global_config_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Global configuration updated successfully.")
        |> redirect(to: admin_global_config_path(conn, :show))

      {:error, %Changeset{} = changeset} ->
        render(conn, "show.html",
          global_config: conn.assigns.global_config,
          changeset: changeset
        )
    end
  end
end
