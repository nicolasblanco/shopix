defmodule ShopixWeb.Admin.PropertyController do
  use ShopixWeb, :controller

  alias Shopix.Schema.Property
  alias Shopix.Admin

  def index(conn, params) do
    page = Admin.list_properties(params)

    render(conn, "index.html",
      properties: page.entries,
      page: page
    )
  end

  def new(conn, _params) do
    changeset = Admin.change_property(%Property{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"property" => property_params}) do
    case Admin.create_property(property_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Property created successfully.")
        |> redirect(to: admin_property_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    property = Admin.get_property!(id)
    changeset = Admin.change_property(property)
    render(conn, "edit.html", property: property, changeset: changeset)
  end

  def update(conn, %{"id" => id, "property" => property_params}) do
    property = Admin.get_property!(id)

    case Admin.update_property(property, property_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Property updated successfully.")
        |> redirect(
          to: admin_property_path(conn, :index, options_reject_nil(page: conn.params["page"]))
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", property: property, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    property = Admin.get_property!(id)
    {:ok, _property} = Admin.delete_property(property)

    conn
    |> put_flash(:info, "Property deleted successfully.")
    |> redirect(to: admin_property_path(conn, :index))
  end
end
