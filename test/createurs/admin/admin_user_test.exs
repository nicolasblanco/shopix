defmodule Shopix.Admin.AdminUserTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.User

  @valid_attrs %{email: "user@foo.bar", password: "test123"}
  @update_attrs %{email: "super_user@foo.bar", password: "test321"}
  @invalid_attrs %{email: nil, password: nil}

  test "list_users/1 returns all users" do
    user = insert(:user)

    assert %{entries: users} = Admin.list_users()
    assert Enum.count(users) == 1
    assert (users |> Enum.at(0)).id == user.id
  end

  test "get_user!/1 returns the user with given id" do
    user = insert(:user)
    user_get = Admin.get_user!(user.id)
    assert user.id == user_get.id
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Admin.create_user(@valid_attrs)
    assert user.email == "user@foo.bar"
    assert user.encrypted_password |> String.length() > 10
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = insert(:user)
    previous_encrypted_password = user.encrypted_password
    assert {:ok, user} = Admin.update_user(user, @update_attrs)
    assert %User{} = user
    assert user.email == "super_user@foo.bar"
    assert user.encrypted_password != previous_encrypted_password
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = insert(:user)
    assert {:error, %Ecto.Changeset{}} = Admin.update_user(user, @invalid_attrs)
    user_get = Admin.get_user!(user.id)
    assert user_get.email == user.email
  end

  test "delete_user/1 deletes the user" do
    user = insert(:user)
    assert {:ok, %User{}} = Admin.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = insert(:user)
    assert %Ecto.Changeset{} = Admin.change_user(user)
  end

  test "find_and_confirm_password/1 with valid data checks validity of password and returns user" do
    user = insert(:user, %{email: "foo@bar.com"})

    assert {:ok, user_returned} =
             Admin.find_and_confirm_password(%{"email" => "foo@bar.com", "password" => "test1234"})

    assert user.id == user_returned.id
  end

  test "find_and_confirm_password/1 with invalid data returns an error" do
    insert(:user, %{email: "foo@bar.com"})

    assert {:error, :invalid_credentials} =
             Admin.find_and_confirm_password(%{"email" => "foo@bar.com", "password" => "foobar"})

    assert {:error, :invalid_params} = Admin.find_and_confirm_password(nil)
  end
end
