defmodule Shopix.Admin.PropertyTest do
  use ExUnit.Case, async: true
  alias Shopix.Admin
  alias Shopix.Schema.Property

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.Property.changeset(%Property{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.Property.changeset(%Property{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:key]
    end
  end
end
