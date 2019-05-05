defmodule ShopixWeb.Admin.TranslationController do
  use ShopixWeb, :controller

  alias Shopix.Schema.Translation
  alias Shopix.Admin

  def index(conn, params) do
    page = Admin.list_translations(params)

    render(conn, "index.html",
      translations: page.entries,
      page: page
    )
  end

  def new(conn, _params) do
    changeset = Admin.change_translation(%Translation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"translation" => translation_params}) do
    case Admin.create_translation(translation_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Translation created successfully.")
        |> redirect(to: admin_translation_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    translation = Admin.get_translation!(id)
    changeset = Admin.change_translation(translation)
    render(conn, "edit.html", translation: translation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "translation" => translation_params}) do
    translation = Admin.get_translation!(id)

    case Admin.update_translation(translation, translation_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Translation updated successfully.")
        |> redirect(
          to:
            admin_translation_path(
              conn,
              :index,
              options_reject_nil(
                to_translate: conn.params["to_translate"],
                page: conn.params["page"]
              )
            )
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", translation: translation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    translation = Admin.get_translation!(id)
    {:ok, _translation} = Admin.delete_translation(translation)

    conn
    |> put_flash(:info, "Translation deleted successfully.")
    |> redirect(to: admin_translation_path(conn, :index))
  end
end
