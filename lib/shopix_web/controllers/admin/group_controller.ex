defmodule ShopixWeb.Admin.GroupController do
  use ShopixWeb, :controller

  alias Shopix.Schema.Group
  alias Shopix.Admin
  alias Ecto.Changeset

  def index(conn, params) do
    page = Admin.list_groups(params)

    render conn, "index.html", groups: page.entries,
                               page: page
  end

  def new(conn, _params) do
    changeset = Admin.change_group(%Group{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"group" => group_params}) do
    case Admin.create_group(group_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: admin_group_path(conn, :index))
      {:error, %Changeset{} = changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    group = Admin.get_group!(id)
    changeset = Admin.change_group(group)

    render conn, "edit.html", group: group,
                              changeset: changeset
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Admin.get_group!(id)

    case Admin.update_group(group, group_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: admin_group_path(conn, :index, options_reject_nil(page: conn.params["page"])))
      {:error, %Changeset{} = changeset} ->
        render conn, "edit.html", group: group,
                                  changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Admin.get_group!(id)
    {:ok, _group} = Admin.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: admin_group_path(conn, :index))
  end
end
