defmodule ShopixWeb.Api.ShopView do
  use ShopixWeb, :view

  def render("show.json", %{global_config: global_config}) do
    %{
      global_config: global_config_json(global_config)
    }
  end

  def global_config_json(global_config) do
    %{
      default_locale: global_config.default_locale,
      available_locales: global_config.available_locales
    }
  end
end
