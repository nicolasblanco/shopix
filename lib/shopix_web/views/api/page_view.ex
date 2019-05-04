defmodule ShopixWeb.Api.PageView do
  use ShopixWeb, :view

  def render("show.json", %{page: page, locale: locale}) do
    %{
      page: page_json(page, locale),
      locale: locale
    }
  end

  def page_json(page, locale) do
    %{
      id: page.id,
      slug: t_field(page, :slug, locale),
      content: t_field(page, :content, locale),
      image_url: image_url(page)
    }
  end
end
