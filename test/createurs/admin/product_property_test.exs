defmodule Shopix.Admin.ProductPropertyTest do
  use ExUnit.Case, async: true
  alias Shopix.Admin
  alias Shopix.Schema.ProductProperty

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.ProductProperty.changeset(%ProductProperty{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.ProductProperty.changeset(%ProductProperty{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:property_id]
    end
  end
end
