defmodule Shopix.Front.OrderTest do
  use ExUnit.Case, async: true
  alias Shopix.Front
  alias Shopix.Schema.Order

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Front.Order.changeset(%Order{}, %{})
    end
  end

  describe "changeset_address/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Front.Order.changeset_address(%Order{}, %{})
    end

    test "validates requirements" do
      changeset = Front.Order.changeset_address(%Order{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:email]
      assert {_, [validation: :required]} = changeset.errors[:first_name]
      assert {_, [validation: :required]} = changeset.errors[:last_name]
      assert {_, [validation: :required]} = changeset.errors[:address_1]
      assert {_, [validation: :required]} = changeset.errors[:zip_code]
      assert {_, [validation: :required]} = changeset.errors[:city]
      assert {_, [validation: :required]} = changeset.errors[:country_code]
      assert {_, [validation: :required]} = changeset.errors[:phone]
    end

    test "validates format" do
      changeset = Front.Order.changeset_address(%Order{}, %{email: "foobar"})

      assert changeset.valid? == false
      assert {_, [validation: :format]} = changeset.errors[:email]
    end
  end
end
