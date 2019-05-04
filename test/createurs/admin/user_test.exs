defmodule Shopix.Admin.UserTest do
  use ExUnit.Case, async: true
  alias Shopix.Admin
  alias Shopix.Schema.User
  alias Comeonin.Bcrypt

  describe "registration_changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.User.registration_changeset(%User{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.User.registration_changeset(%User{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:email]
      assert {_, [validation: :required]} = changeset.errors[:password]
    end

    test "sets the encrypted password" do
      changeset = Admin.User.registration_changeset(%User{}, %{email: "nicolas@nicolasblanco.fr",
                                                               password: "test1234"})
      assert changeset.valid? == true
      assert changeset.changes |> Map.has_key?(:encrypted_password) == true
    end
  end

  describe "changeset/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = Admin.User.changeset(%User{}, %{})
    end

    test "validates requirements" do
      changeset = Admin.User.changeset(%User{}, %{})

      assert changeset.valid? == false
      assert {_, [validation: :required]} = changeset.errors[:email]
      assert changeset.errors[:password] == nil
    end

    test "does not change the encrypted password if there is no change to it" do
      changeset = Admin.User.changeset(%User{}, %{email: "nicolas@nicolasblanco.fr", password: ""})
      assert changeset.valid? == true
      assert changeset.changes |> Map.has_key?(:email) == true
      assert changeset.changes |> Map.has_key?(:encrypted_password) == false
    end

    test "changes the encrypted password if there a change to it" do
      changeset = Admin.User.changeset(%User{}, %{email: "nicolas@nicolasblanco.fr", password: "test1234"})
      assert changeset.valid? == true
      assert changeset.changes |> Map.has_key?(:email) == true
      assert changeset.changes |> Map.has_key?(:encrypted_password) == true
    end
  end

  describe "valid_password?/2" do
    test "returns true if the given user has the given password" do
      user = %User{encrypted_password: Bcrypt.hashpwsalt("test1234")}

      assert Admin.User.valid_password?(user, "test1234") == true
      assert Admin.User.valid_password?(user, "foobar") == false
      assert Admin.User.valid_password?(user, "") == false
    end
  end
end
