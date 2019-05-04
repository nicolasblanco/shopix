defmodule ShopixWeb.Api.CheckoutView do
  use ShopixWeb, :view
  alias ShopixWeb.Api.CartView

  def render("show.json", %{order: order, locale: locale}) do
    CartView.render("show.json", order: order, locale: locale)
  end

  def render("error.json", %{changeset: changeset}) do
    %{
      errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    }
  end
end
