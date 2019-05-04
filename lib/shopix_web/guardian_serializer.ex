defmodule ShopixWeb.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Shopix.Repo
  alias Shopix.Schema.User

  def for_token(%User{} = user), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
