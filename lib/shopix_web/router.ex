defmodule ShopixWeb.Router do
  use ShopixWeb, :router

  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated, handler: ShopixWeb.Admin.SessionController
    plug ShopixWeb.Plug.CurrentUser
    plug ShopixWeb.Plug.GlobalConfig
    plug ShopixWeb.Plug.AdminLocale
  end

  pipeline :front do
    plug ShopixWeb.Plug.GlobalConfig
    plug ShopixWeb.Plug.Locale
    plug ShopixWeb.Plug.CurrentOrder

    plug :put_layout, {ShopixWeb.LayoutView, :front}
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug ShopixWeb.Plug.GlobalConfig
    plug ShopixWeb.Plug.Locale
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  scope "/api", ShopixWeb.Api, as: :api do
    pipe_through :api

    resources "/shop", ShopController, only: [:show], singleton: true
  end

  scope "/api/:locale", ShopixWeb.Api, as: :api do
    pipe_through :api

    resources "/products", ProductController, only: [:index, :show]
    resources "/pages", PageController, only: [:show]

    resources "/cart", CartController, only: [:show]
    post "/cart/add", CartController, :add
    put "/cart/line_item_decrease", CartController, :line_item_decrease
    put "/cart/line_item_increase", CartController, :line_item_increase
    delete "/cart/line_item_delete", CartController, :line_item_delete

    put "/checkout/validate_payment", CheckoutController, :validate_payment
  end

  scope "/admin", ShopixWeb.Admin, as: :admin do
    pipe_through [:browser, :admin_auth]

    resources "/products", ProductController
    resources "/groups", GroupController
    resources "/properties", PropertyController
    resources "/users", UserController
    resources "/translations", TranslationController
    resources "/orders", OrderController
    resources "/pages", PageController
    resources "/global_config", GlobalConfigController, only: [:show, :update], singleton: true

    get "/session/logout", SessionController, :delete

    get "/auth/:provider", SessionController, :request
    get "/auth/:provider/callback", SessionController, :callback

    get "/", HomeController, :index
  end

  scope "/session", ShopixWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/", SessionController, only: [:new, :create], singleton: true
  end

  scope "/:locale", ShopixWeb.Front do
    pipe_through [:browser, :front]

    resources "/products", ProductController, only: [:show, :index]
    resources "/pages", PageController, only: [:show]

    resources "/cart", CartController, only: [:show], singleton: true
    post "/cart/add", CartController, :add
    put "/cart/line_item_decrease", CartController, :line_item_decrease
    put "/cart/line_item_increase", CartController, :line_item_increase
    delete "/cart/line_item_delete", CartController, :line_item_delete

    get "/shop", HomeController, :shop

    get "/checkout/address", CheckoutController, :address
    put "/checkout/validate_address", CheckoutController, :validate_address

    get "/checkout/payment", CheckoutController, :payment
    put "/checkout/validate_payment", CheckoutController, :validate_payment

    get "/checkout/complete", CheckoutController, :complete

    get "/", HomeController, :index
  end

  scope "/", ShopixWeb.Front do
    pipe_through [:browser, :front]

    get "/", HomeController, :index
  end
end
