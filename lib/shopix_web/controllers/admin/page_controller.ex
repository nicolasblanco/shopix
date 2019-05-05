defmodule ShopixWeb.Admin.PageController do
  use ShopixWeb, :controller

  alias Shopix.Schema.Page
  alias Shopix.Admin

  def index(conn, params) do
    page = Admin.list_pages(params)

    render(conn, "index.html",
      pages: page.entries,
      page: page
    )
  end

  def new(conn, _params) do
    changeset = Admin.change_page(%Page{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case Admin.create_page(page_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: admin_page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    page = Admin.get_page!(id)
    changeset = Admin.change_page(page)
    render(conn, "edit.html", page: page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Admin.get_page!(id)

    case Admin.update_page(page, page_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(
          to: admin_page_path(conn, :index, options_reject_nil(page: conn.params["return_page"]))
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Admin.get_page!(id)
    {:ok, _page} = Admin.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: admin_page_path(conn, :index))
  end
end
