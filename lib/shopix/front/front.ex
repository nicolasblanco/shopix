defmodule Shopix.Front do
  import Ecto.Query, warn: false
  alias Shopix.Repo
  alias Shopix.Front

  alias Shopix.Schema.{Order, Page, Product, LineItem, Translation}

  def list_products(params \\ %{}) do
    (from p in Product, where: p.displayed == true)
    |> filter_by_group(params["filter"])
    |> Repo.paginate(params)
  end

  def filter_by_group(query, nil), do: query
  def filter_by_group(query, group_key) do
    from q in query, join: g in assoc(q, :groups), where: g.key == ^group_key
  end

  def get_related_products(id) do
    from(p in Product, where: p.id != ^id, limit: 4)
    |> Repo.all()
  end

  def get_product_by_slug!(slug, locale) do
    query = from p in Product,
      where: fragment("?->>?", p.slug_translations, ^locale) == ^slug,
      preload: [product_properties: :property]

      query |> first |> Repo.one!
  end

  def get_page_by_slug!(slug, locale) do
    from(p in Page,
      where: fragment("?->>?", p.slug_translations, ^locale) == ^slug)
    |> first |> Repo.one!
  end

  def get_product!(id) do
    Product |> preload([product_properties: :property]) |> Repo.get!(id)
  end

  def get_translations(translation_key) do
    from(t in Translation,
         where: like(t.key, ^("#{translation_key}.%")) or like(t.key, ^("front.layout.%")))
    |> Repo.all()
  end

  def get_order(id, config \\ %{}) do
    case Repo.get(Order, id) do
      %Order{} = order -> order
                          |> Repo.preload([line_items: {from(l in LineItem, order_by: l.inserted_at), :product}])
                          |> Order.compute_line_items
                          |> Order.compute_properties(config)
      nil -> nil
    end
  end

  def change_order(%Order{} = order) do
    order
    |> Front.Order.changeset(%{})
  end

  def order_validate_payment(%Order{} = order, global_config) do
    order
    |> Front.Order.changeset_payment(global_config)
    |> Repo.update()
  end

  def order_validate_address(%Order{} = order, attrs) do
    order
    |> Front.Order.changeset_address(attrs)
    |> Repo.update()
  end

  def get_line_item!(order_id, line_item_id) do
    query = from li in LineItem, where: li.order_id == ^order_id and li.id == ^line_item_id
    query |> Repo.one!
  end

  def order_line_item_decrease!(%Order{id: order_id}, line_item_id) do
    line_item = get_line_item!(order_id, line_item_id)

    line_item |> LineItem.decrease_quantity |> Repo.update!
  end

  def order_line_item_increase!(%Order{id: order_id}, line_item_id) do
    line_item = get_line_item!(order_id, line_item_id)

    line_item |> LineItem.increase_quantity |> Repo.update!
  end

  def order_line_item_delete!(%Order{id: order_id}, line_item_id) do
    line_item = get_line_item!(order_id, line_item_id)

    line_item |> Repo.delete!
  end

  def create_or_add_order_with_product!(%Order{} = order, %Product{} = product, _), do: add_product_to_order!(order, product)
  def create_or_add_order_with_product!(nil, %Product{} = product, config), do: create_order_with_product!(product, config)

  def create_order_with_product!(%Product{} = product, config) do
    case %Order{}
         |> Front.Order.changeset(%{line_items: [%{product_id: product.id, quantity: 1}]})
         |> Repo.insert do
           {:ok, order} -> get_order(order.id, config)
    end
  end

  def add_product_to_order!(%Order{} = order, %Product{} = product) do
    line_item = case Enum.find(order.line_items, fn li -> li.product_id == product.id end) do
      nil -> order |> Ecto.build_assoc(:line_items, product_id: product.id) |> Front.LineItem.changeset(%{})
      line_item -> LineItem.increase_quantity(line_item)
    end

    Repo.insert_or_update!(line_item)
    order
  end

  def first_product do
    Product |> first |> Repo.one!
  end

  def previous_product(%Product{id: product_id}) do
    query = from p in Product,
            where: p.id < ^product_id
    query |> last |> Repo.one
  end

  def next_product(%Product{id: product_id}) do
    query = from p in Product,
            where: p.id > ^product_id
    query |> first |> Repo.one
  end
end
