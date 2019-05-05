defmodule Shopix.FrontTest do
  use Shopix.DataCase, async: true

  alias Shopix.Front

  describe "products" do
    test "get_product_by_slug!/2 returns the product given a specific slug and specific locale" do
      product = insert(:product)

      product_get = Front.get_product_by_slug!("my-great-product", "en")
      assert product_get.id == product.id
    end

    test "get_product!/1 returns the product given a specific id" do
      product = insert(:product)

      product_get = Front.get_product!(product.id)
      assert product_get.id == product.id
    end

    test "first_product/0 returns the first product in the database" do
      product = insert(:product)
      insert(:product)

      assert Front.first_product() == product
    end

    test "previous_product/1 returns the product before the given product" do
      product_1 = insert(:product)
      product_2 = insert(:product)
      insert(:product)

      assert Front.previous_product(product_2) == product_1
    end

    test "next_product/1 returns the product before the given product" do
      insert(:product)
      product_2 = insert(:product)
      product_3 = insert(:product)

      assert Front.next_product(product_2) == product_3
    end
  end

  describe "pages" do
    test "get_page_by_slug!/2 returns the page given a specific slug and specific locale" do
      page = insert(:page)

      assert Front.get_page_by_slug!("a-propos", "fr") == page
    end
  end

  describe "translations" do
    test "get_translations/1 returns all the translations for a specify key with layout keys" do
      translation = insert(:translation)
      translation_layout = insert(:translation, %{key: "front.layout.name"})

      assert Front.get_translations("foobar") == [translation, translation_layout]
    end
  end

  describe "orders" do
    test "get_order/1 returns the order for a specific id" do
      order = insert(:order)

      order_get = Front.get_order(order.id, %{shipping_cost_default_amount: 10})
      assert order_get.id == order.id
    end

    test "get_order/1 returns nil if the specific order id is not found" do
      assert Front.get_order(1234, %{shipping_cost_default_amount: 10}) == nil
    end

    test "change_order/1 returns a changeset for a given order" do
      order = insert(:order)
      assert %Ecto.Changeset{} = Front.change_order(order)
    end

    test "order_validate_payment/1 updates the given order after payment" do
      order = insert(:order, %{completed_at: nil, shipping_cost_amount: nil})

      assert {:ok, order} =
               Front.order_validate_payment(order, %{
                 vat_percentage: Decimal.new(20),
                 shipping_cost_default_amount: 10
               })

      assert order.completed_at != nil
      assert order.shipping_cost_amount != nil
    end

    test "order_validate_address/1 updates the given order after address step when data is valid" do
      order = insert(:order)

      assert {:ok, order} =
               Front.order_validate_address(order, %{first_name: "Foo", last_name: "Bar"})

      assert order.first_name == "Foo"
      assert order.last_name == "Bar"
    end

    test "order_validate_address/1 updates the given order after address step when data is invalid" do
      order = insert(:order)

      assert {:error, %Ecto.Changeset{}} =
               Front.order_validate_address(order, %{first_name: "", last_name: ""})

      assert order.first_name == "Nicolas"
      assert order.last_name == "Blanco"
    end

    test "create_or_add_order_with_product!/2 with an existing order creates a line_item" do
      order = insert(:order)
      product = insert(:product)

      Front.create_or_add_order_with_product!(order, product, %{shipping_cost_default_amount: 10})
      order = Front.get_order(order.id, %{shipping_cost_default_amount: 10})
      assert order.line_items |> Enum.count() == 2
      assert (order.line_items |> Enum.at(1)).quantity == 1
    end

    test "create_or_add_order_with_product!/2 with no order creates an order and a line_item" do
      product = insert(:product)

      order =
        Front.create_or_add_order_with_product!(nil, product, %{shipping_cost_default_amount: 10})

      order = Front.get_order(order.id, %{shipping_cost_default_amount: 10})
      assert order.line_items |> Enum.count() == 1
      assert (order.line_items |> Enum.at(0)).quantity == 1
    end

    test "add_product_to_order!/2 updates the quantity of a line_item if product is already in order" do
      order = insert(:order)
      product = (order.line_items |> Enum.at(0)).product

      order = Front.add_product_to_order!(order, product)
      order = Front.get_order(order.id, %{shipping_cost_default_amount: 10})
      assert order.line_items |> Enum.count() == 1
      assert (order.line_items |> Enum.at(0)).quantity == 4
    end

    test "add_product_to_order!/2 creates a line_item with a new product" do
      order = insert(:order, %{line_items: []})
      product = insert(:product)

      order = Front.add_product_to_order!(order, product)
      order = Front.get_order(order.id, %{shipping_cost_default_amount: 10})
      assert order.line_items |> Enum.count() == 1
      assert (order.line_items |> Enum.at(0)).quantity == 1
    end
  end

  describe "line_items" do
    test "get_line_item!/2 returns the line item with a specific order_id and line_item_id" do
      order = insert(:order)
      line_item = order.line_items |> Enum.at(0)

      line_item_get = Front.get_line_item!(order.id, line_item.id)
      assert line_item.id == line_item_get.id
    end

    test "get_line_item!/2 raises if no line_item is found with the provided order_id and line_item_id" do
      assert_raise Ecto.NoResultsError, fn -> Front.get_line_item!(1234, 5432) end
    end

    test "order_line_item_decrease!/2 decreases the quantity for a specific order and line_item_id" do
      order = insert(:order)
      line_item = order.line_items |> Enum.at(0)

      line_item = Front.order_line_item_decrease!(order, line_item.id)
      assert line_item.quantity == 2
    end

    test "order_line_item_increase!/2 increases the quantity for a specific order and line_item_id" do
      order = insert(:order)
      line_item = order.line_items |> Enum.at(0)

      line_item = Front.order_line_item_increase!(order, line_item.id)
      assert line_item.quantity == 4
    end

    test "order_line_item_delete!/2 deletes the line_item for a specific order and line_item_id" do
      order = insert(:order)
      line_item = order.line_items |> Enum.at(0)

      Front.order_line_item_delete!(order, line_item.id)
      order = Front.get_order(order.id, %{shipping_cost_default_amount: 10})
      assert order.line_items |> Enum.empty?() == true
    end
  end
end
