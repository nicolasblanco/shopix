defmodule Shopix.Admin.AdminProductTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.Product

  @valid_attrs %{price: "42,00 €",
                  sku: "FOO-BAR",
                  name_translations: %{"fr" => "Magnifique produit",
                                      "en" => "Great product"},
                  description_translations: %{"fr" => "Super produit, achetez-le !",
                                              "en" => "Wonderful product, buy it!"}
                }
  @update_attrs %{price: "50,00 €",
                  sku: "FOO-BAR-2",
                  name_translations: %{"fr" => "Magnifique super produit",
                                        "en" => "Great and cool product"},
                  description_translations: %{"fr" => "Super top produit, achetez-le !",
                                              "en" => "Wonderful product, buy it for sure!"}
                }
  @invalid_attrs %{price: nil, sku: nil}

  test "list_products/1 returns all products" do
    product = insert(:product)
    assert %{entries: products} = Admin.list_products()
    assert products == [product]
  end

  test "get_product!/1 returns the product with given id" do
    product = insert(:product)
    product_get = Admin.get_product!(product.id)

    assert product_get.id == product.id
  end

  test "create_product/1 with valid data creates a product" do
    assert {:ok, %Product{} = product} = Admin.create_product(@valid_attrs)
    assert product.sku == "FOO-BAR"
    assert product.price.amount == 4200
    assert product.name_translations["fr"] == "Magnifique produit"
    assert product.name_translations["en"] == "Great product"
    assert product.slug_translations["fr"] == "magnifique-produit"
    assert product.slug_translations["en"] == "great-product"
    assert product.description_translations["fr"] == "Super produit, achetez-le !"
    assert product.description_translations["en"] == "Wonderful product, buy it!"
  end

  test "create_product/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Admin.create_product(@invalid_attrs)
  end

  test "update_product/2 with valid data updates the product" do
    product = insert(:product)

    assert {:ok, product} = Admin.update_product(product, @update_attrs)
    assert %Product{} = product
    assert product.sku == "FOO-BAR-2"
    assert product.price.amount == 5000
    assert product.name_translations["fr"] == "Magnifique super produit"
    assert product.name_translations["en"] == "Great and cool product"
    assert product.slug_translations["fr"] == "magnifique-super-produit"
    assert product.slug_translations["en"] == "great-and-cool-product"
    assert product.description_translations["fr"] == "Super top produit, achetez-le !"
    assert product.description_translations["en"] == "Wonderful product, buy it for sure!"
  end

  test "update_product/2 with invalid data returns error changeset" do
    product = insert(:product)
    assert {:error, %Ecto.Changeset{}} = Admin.update_product(product, @invalid_attrs)

    product_get = Admin.get_product!(product.id)
    assert product_get.sku == product.sku
  end

  test "delete_product/1 deletes the product" do
    product = insert(:product)

    assert {:ok, %Product{}} = Admin.delete_product(product)
    assert_raise Ecto.NoResultsError, fn -> Admin.get_product!(product.id) end
  end

  test "change_product/1 returns a product changeset" do
    product = insert(:product)
    assert %Ecto.Changeset{} = Admin.change_product(product)
  end
end
