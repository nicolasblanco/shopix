defmodule Shopix.Admin.Page do
  alias Shopix.Schema.Page
  import Ecto.Changeset

  use Shopix.TranslationFields, slug: :name, translated_fields: ~w(name content slug)

  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:key, :images_group_url, :edit_html_only] ++ localized_fields())
    |> change_slugs()
    |> validate_required([:key])
    |> validate_format(:key, ~r/\A[a-z0-9\-_]{3,}\z/)
    |> unique_constraint(:key)
  end
end
