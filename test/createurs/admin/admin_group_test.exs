defmodule Shopix.Admin.AdminGroupTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.Group

  @valid_attrs %{key: "faq"}
  @update_attrs %{key: "new_faq"}
  @invalid_attrs %{key: ""}

  test "list_groups/1 returns all groups paginated" do
    group = insert(:group)
    assert %{entries: groups} = Admin.list_groups(%{})
    assert groups == [group]
  end

  test "get_group!/1 returns the group with given id" do
    group = insert(:group)
    assert Admin.get_group!(group.id) == group
  end

  test "create_group/1 with valid data creates a group" do
    assert {:ok, %Group{} = group} = Admin.create_group(@valid_attrs)
    assert group.key == "faq"
  end

  test "create_group/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Admin.create_group(@invalid_attrs)
  end

  test "update_group/2 with valid data updates the group" do
    group = insert(:group)

    assert {:ok, group} = Admin.update_group(group, @update_attrs)
    assert %Group{} = group
    assert group.key == "new_faq"
  end

  test "update_group/2 with invalid data returns error changeset" do
    group = insert(:group)
    assert {:error, %Ecto.Changeset{}} = Admin.update_group(group, @invalid_attrs)

    assert Admin.get_group!(group.id) == group
  end

  test "delete_group/1 deletes the group" do
    group = insert(:group)

    assert {:ok, %Group{}} = Admin.delete_group(group)
    assert_raise Ecto.NoResultsError, fn -> Admin.get_group!(group.id) end
  end

  test "change_group/1 returns a group changeset" do
    group = insert(:group)
    assert %Ecto.Changeset{} = Admin.change_group(group)
  end
end
