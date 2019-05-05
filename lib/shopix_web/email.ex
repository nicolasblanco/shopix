defmodule ShopixWeb.Email do
  use Bamboo.Phoenix, view: ShopixWeb.EmailView
  import ShopixWeb.TranslationHelpers
  alias Shopix.Front
  alias Shopix.Schema.Order

  def order_complete_email(%Order{} = order, current_locale, global_config) do
    conn = %{
      assigns: %{
        translations: Front.get_translations("email.order_complete"),
        current_locale: current_locale
      }
    }

    new_email()
    |> to(order.email)
    |> from(global_config.emails_from)
    |> subject(t(conn, "email.order_complete.subject", plain: true))
    |> render("order_complete.html",
      current_locale: conn.assigns.current_locale,
      conn: conn,
      order: order
    )
  end
end
