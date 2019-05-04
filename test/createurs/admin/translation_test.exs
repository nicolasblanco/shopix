defmodule Shopix.Admin.TranslationTest do
  use ExUnit.Case, async: true
  alias Shopix.Admin
  alias Shopix.Schema.Translation

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.Translation.changeset(%Translation{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.Translation.changeset(%Translation{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:key]
    end
  end
end
