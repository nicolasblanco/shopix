defmodule ShopixWeb.Admin.ProductControllerTest do
  use ShopixWeb.ConnCase, async: true

  @valid_attrs %{
    price: "42,00 €",
    sku: "FOO-BAR",
    name_fr: "Magnifique produit",
    name_en: "Great product",
    description_fr: "Super produit, achetez-le !",
    description_en: "Wonderful product, buy it!"
  }
  @update_attrs %{
    price: "50,00 €",
    sku: "FOO-BAR-2",
    name_fr: "Magnifique super produit",
    name_en: "Great and cool product",
    description_fr: "Super top produit, achetez-le !",
    description_en: "Wonderful product, buy it for sure!"
  }
  @invalid_attrs %{price: nil, sku: nil}

  test "index/2 responds with the products" do
    insert(:product, sku: "FOO-BAR")

    conn =
      guardian_login(insert(:user))
      |> get(admin_product_path(build_conn(), :index))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "FOO-BAR"
  end

  test "new/2 responds with a form for a new product" do
    conn =
      guardian_login(insert(:user))
      |> get(admin_product_path(build_conn(), :new))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New product"
  end

  test "create/2 with valid attributes redirects and sets flash" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_product_path(build_conn(), :create), %{"product" => @valid_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "create/2 with invalid attributes renders form" do
    conn =
      guardian_login(insert(:user))
      |> post(admin_product_path(build_conn(), :create), %{"product" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "New product"
  end

  test "edit/2 responds with the edition of the product" do
    product = insert(:product)

    conn =
      guardian_login(insert(:user))
      |> get(admin_product_path(build_conn(), :edit, product.id))

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit product"
  end

  test "update/2 with valid attributes redirects and sets flash" do
    product = insert(:product)

    conn =
      guardian_login(insert(:user))
      |> put(admin_product_path(build_conn(), :update, product.id), %{"product" => @update_attrs})

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end

  test "update/2 with invalid attributes renders form" do
    product = insert(:product)

    conn =
      guardian_login(insert(:user))
      |> put(admin_product_path(build_conn(), :update, product.id), %{"product" => @invalid_attrs})

    assert html_response(conn, 200)
    assert conn.resp_body =~ "Edit product"
  end

  test "delete/2 redirects and sets flash" do
    product = insert(:product)

    conn =
      guardian_login(insert(:user))
      |> delete(admin_product_path(build_conn(), :update, product.id))

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "successfully"
  end
end
