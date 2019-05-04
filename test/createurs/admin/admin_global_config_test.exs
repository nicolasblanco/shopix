defmodule Shopix.Admin.AdminGlobalConfigTest do
  use Shopix.DataCase, async: true

  alias Shopix.Admin
  alias Shopix.Schema.GlobalConfig

  @update_attrs %{name: "My hyper cool shop"}
  @invalid_attrs %{name: nil}

  test "change_global_config/1 returns a global config changeset" do
    global_config = insert(:global_config)
    assert %Ecto.Changeset{} = Admin.change_global_config(global_config)
  end

  test "update_global_config/2 with valid data updates the global config" do
    global_config = insert(:global_config)

    assert {:ok, global_config} = Admin.update_global_config(global_config, @update_attrs)
    assert %GlobalConfig{} = global_config
    assert global_config.name == "My hyper cool shop"
  end

  test "update_global_config/2 with invalid data returns error changeset" do
    global_config = insert(:global_config)
    assert {:error, %Ecto.Changeset{}} = Admin.update_global_config(global_config, @invalid_attrs)
  end
end
