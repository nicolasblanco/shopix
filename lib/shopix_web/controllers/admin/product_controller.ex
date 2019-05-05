defmodule ShopixWeb.Admin.ProductController do
  use ShopixWeb, :controller

  alias Shopix.Schema.{Product, Group}
  alias Shopix.{Admin, Repo}
  alias Ecto.Changeset

  def index(conn, params) do
    page = Admin.list_products(params)

    render(conn, "index.html",
      products: page.entries,
      page: page
    )
  end

  def new(conn, _params) do
    changeset = Admin.change_product(%Product{})

    render(conn, "new.html",
      changeset: changeset,
      properties: Admin.list_properties(),
      groups: Repo.all(Group),
      product_properties: Changeset.get_field(changeset, :product_properties)
    )
  end

  def create(conn, %{"product" => product_params}) do
    case Admin.create_product(product_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: admin_product_path(conn, :index))

      {:error, %Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          properties: Admin.list_properties(),
          groups: Repo.all(Group),
          product_properties: Changeset.get_field(changeset, :product_properties)
        )
    end
  end

  def edit(conn, %{"id" => id}) do
    product = Admin.get_product!(id)
    changeset = Admin.change_product(product)

    render(conn, "edit.html",
      product: product,
      changeset: changeset,
      properties: Admin.list_properties(),
      groups: Repo.all(Group),
      product_properties: Changeset.get_field(changeset, :product_properties)
    )
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Admin.get_product!(id)

    case Admin.update_product(product, product_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(
          to: admin_product_path(conn, :index, options_reject_nil(page: conn.params["page"]))
        )

      {:error, %Changeset{} = changeset} ->
        render(conn, "edit.html",
          product: product,
          changeset: changeset,
          properties: Admin.list_properties(),
          groups: Repo.all(Group),
          product_properties: Changeset.get_field(changeset, :product_properties)
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Admin.get_product!(id)
    {:ok, _product} = Admin.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: admin_product_path(conn, :index))
  end
end
