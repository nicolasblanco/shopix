# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Shopix.Repo.insert!(%Shopix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Shopix.Schema.{User, GlobalConfig}
alias Shopix.{Repo, Admin}

user =
  Admin.User.changeset(%User{}, %{
    email: System.get_env("ADMIN_EMAIL"),
    password: System.get_env("ADMIN_PASSWORD")
  })

Repo.insert!(user)

global_config = Admin.GlobalConfig.changeset(%GlobalConfig{}, %{})
Repo.insert!(global_config)
