defmodule Shopix.Front.LineItemTest do
  use ExUnit.Case, async: true
  alias Shopix.Front
  alias Shopix.Schema.LineItem

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Front.LineItem.changeset(%LineItem{}, %{})
    end

    test "validates requirements" do
      changeset = Front.LineItem.changeset(%LineItem{}, %{quantity: ""})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:product_id]
    end
  end
end
