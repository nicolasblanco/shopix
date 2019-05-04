defmodule Shopix.Admin.ProductTest do
  use ExUnit.Case, async: true
  alias Shopix.Admin
  alias Shopix.Schema.Product

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.Product.changeset(%Product{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.Product.changeset(%Product{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:sku]
      assert {_, [validation: :required]} = changeset.errors[:price]
    end
  end
end
