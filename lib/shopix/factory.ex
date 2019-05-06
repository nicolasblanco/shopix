defmodule Shopix.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Shopix.Repo
  alias Shopix.Schema

  def user_factory do
    %Schema.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "test1234",
      encrypted_password: Comeonin.Bcrypt.hashpwsalt("test1234")
    }
  end

  def product_factory do
    %Schema.Product{
      price: 1000,
      sku: sequence(:sku, &"sku-#{&1}"),
      name_translations: %{"en" => "My great product", "fr" => "Mon super produit"},
      description_translations: %{
        "en" => "Cool description of my great product",
        "fr" => "Ceci est un super produit"
      },
      slug_translations: %{"en" => "my-great-product", "fr" => "mon-super-produit"}
    }
  end

  def property_factory do
    %Schema.Property{
      key: "width",
      name_translations: %{"en" => "Width", "fr" => "Largeur"}
    }
  end

  def line_item_factory do
    %Schema.LineItem{
      product: build(:product),
      quantity: 3
    }
  end

  def order_factory do
    %Schema.Order{
      email: sequence(:email, &"email-#{&1}@example.com"),
      first_name: "Nicolas",
      last_name: "Blanco",
      company_name: "Shopix",
      address_1: "159 rue de Charonne",
      address_2: nil,
      zip_code: "75011",
      city: "Paris",
      country_state: nil,
      country_code: "FR",
      phone: "+33673730284",
      vat_percentage: Decimal.new(20),
      completed_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      shipping_cost_amount: 10,
      line_items: [build(:line_item)]
    }
  end

  def translation_factory do
    %Schema.Translation{
      key: sequence(:translation_key, &"foobar.foo-#{&1}"),
      value_translations: %{"en" => "Hello world", "fr" => "Salut le monde"}
    }
  end

  def page_factory do
    %Schema.Page{
      key: sequence(:page_key, &"about-#{&1}"),
      content_translations: %{
        "fr" => "A propos de nous... Nous sommes les meilleurs ;)",
        "en" => "About us... We are the best ;)"
      },
      name_translations: %{"fr" => "A propos", "en" => "About"},
      slug_translations: %{"fr" => "a-propos", "en" => "about"}
    }
  end

  def group_factory do
    %Schema.Group{
      key: sequence(:page_key, &"group-#{&1}")
    }
  end

  def global_config_factory do
    %Schema.GlobalConfig{}
  end
end
