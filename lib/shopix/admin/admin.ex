defmodule Shopix.Admin do
  import Ecto.Query, warn: false
  alias Shopix.Repo

  alias Shopix.Admin

  alias Shopix.Schema.{Product, Group, Order, Page, User, Property, Translation, GlobalConfig}

  def list_products(params \\ %{}) do
    Product
    |> order_by([desc: :inserted_at])
    |> filter_by_group(params["group_key"])
    |> Repo.paginate(params)
  end

  def filter_by_group(query, nil), do: query
  def filter_by_group(query, group_key) do
    from q in query, join: g in assoc(q, :groups), where: g.key == ^group_key
  end

  def get_product!(id) do
    Product
    |> preload([:product_properties, :groups])
    |> Repo.get!(id)
  end

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Admin.Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Admin.Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def change_product(%Product{} = product) do
    product
    |> Admin.Product.changeset(%{})
  end

  def list_groups(params \\ %{}) do
    Group
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)
  end

  def get_group!(id) do
    Group
    |> Repo.get!(id)
  end

  def create_group(attrs \\ %{}) do
    %Group{}
    |> Admin.Group.changeset(attrs)
    |> Repo.insert()
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Admin.Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group) do
    group
    |> Admin.Group.changeset(%{})
  end

  def list_users(params \\ %{}) do
    User
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> Admin.User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> Admin.User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    Admin.User.changeset(user, %{})
  end

  def find_and_confirm_password(%{"email" => email, "password" => password})
    when is_binary(email) and is_binary(password) do
    user = Repo.get_by(User, email: email)

    if user && Admin.User.valid_password?(user, password) do
      {:ok, user}
    else
      {:error, :invalid_credentials}
    end
  end
  def find_and_confirm_password(_), do: {:error, :invalid_params}

  def list_properties(params) do
    Property
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)
  end
  def list_properties() do
    Property
    |> order_by([desc: :inserted_at])
    |> Repo.all()
  end

  def get_property!(id) do
    Repo.get!(Property, id)
  end

  def create_property(attrs \\ %{}) do
    %Property{}
    |> Admin.Property.changeset(attrs)
    |> Repo.insert()
  end

  def update_property(%Property{} = property, attrs) do
    property
    |> Admin.Property.changeset(attrs)
    |> Repo.update()
  end

  def delete_property(%Property{} = property) do
    Repo.delete(property)
  end

  def change_property(%Property{} = property) do
    property
    |> Admin.Property.changeset(%{})
  end

  def get_order!(id) do
    Order
    |> preload([line_items: :product])
    |> Repo.get!(id)
    |> Order.compute_properties()
  end

  def list_orders(params \\ %{}) do
    %{entries: orders} = page = Order
                                |> where([o], not is_nil o.completed_at)
                                |> order_by([desc: :completed_at])
                                |> Repo.paginate(params)

    %{page | entries: orders |> Repo.preload(line_items: :product) |> Enum.map(&Order.compute_properties(&1))}
  end

  def list_translations(params \\ %{})
  def list_translations(%{"to_translate" => "true"} = params) do
    from(t in Translation, where: t.value_translations == ^(%{}) or (is_nil(t.value_translations)))
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)
  end
  def list_translations(params) do
    Translation
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)
  end

  def get_translation!(id), do: Repo.get!(Translation, id)

  def create_translation(attrs \\ %{}) do
    %Translation{}
    |> Admin.Translation.changeset(attrs)
    |> Repo.insert()
  end

  def update_translation(%Translation{} = translation, attrs) do
    translation
    |> Admin.Translation.changeset(attrs)
    |> Repo.update()
  end

  def delete_translation(%Translation{} = translation) do
    Repo.delete(translation)
  end

  def change_translation(%Translation{} = translation) do
    Admin.Translation.changeset(translation, %{})
  end

  def list_pages(params \\ %{}) do
    Page
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)
  end

  def get_page!(id), do: Repo.get!(Page, id)

  def create_page(attrs \\ %{}) do
    %Page{}
    |> Admin.Page.changeset(attrs)
    |> Repo.insert()
  end

  def update_page(%Page{} = page, attrs) do
    page
    |> Admin.Page.changeset(attrs)
    |> Repo.update()
  end

  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  def change_page(%Page{} = page) do
    Admin.Page.changeset(page, %{})
  end

  def change_global_config(%GlobalConfig{} = global_config) do
    Admin.GlobalConfig.changeset(global_config, %{})
  end

  def update_global_config(%GlobalConfig{} = global_config, attrs) do
    global_config
    |> Admin.GlobalConfig.changeset(attrs)
    |> Repo.update()
  end
end
