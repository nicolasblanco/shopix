defmodule Shopix.Guardian do
  use Guardian, otp_app: :shopix

  alias Shopix.Repo
  alias Shopix.Schema.User

  def subject_for_token(%User{} = resource, _claims) do
    sub = "User:#{to_string(resource.id)}"

    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => "User:" <> user_id}) do
    resource = Repo.get(User, user_id)

    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
