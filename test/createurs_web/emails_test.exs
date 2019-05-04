defmodule ShopixWeb.EmailsTest do
  use Shopix.DataCase, async: true
  alias ShopixWeb.Email
  alias Shopix.Front

  test "order_complete_email/1" do
    order = insert(:order)
    order = Front.get_order(order.id)

    email = Email.order_complete_email(order, "en", build(:global_config))

    assert email.to == order.email
    assert email.html_body =~ "30,00 €"
  end
end
