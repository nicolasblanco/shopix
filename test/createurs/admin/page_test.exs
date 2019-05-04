defmodule Shopix.Admin.PageTest do
  use ExUnit.Case, async: true
  alias Shopix.Admin
  alias Shopix.Schema.Page

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.Page.changeset(%Page{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.Page.changeset(%Page{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:key]
    end
  end
end
