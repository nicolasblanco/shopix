defmodule ShopixWeb.TranslationHelpers do
  alias Shopix.Front
  alias Shopix.Repo

  def t_field(data, field, locale) do
    case Map.get(data, :"#{field}_translations") do
      nil -> ""
      translations_field -> Map.get(translations_field, locale) || ""
    end
  end

  def root_path_unless_default_locale(
        %{assigns: %{global_config: %{default_locale: default_locale}}},
        locale
      ) do
    if locale == default_locale, do: "/", else: "/#{locale}"
  end

  def locales_filled_on(
        %{assigns: %{global_config: %{available_locales: available_locales}}},
        data,
        field
      ) do
    available_locales
    |> Enum.filter(fn locale -> t_field(data, field, locale) != "" end)
  end

  def t_slug(data, locale) do
    t_field(data, :slug, locale)
  end

  def t(conn, key, opts \\ [])

  def t(conn, "." <> key, _opts) do
    translation_key = "#{conn.assigns.translation_key}.#{key}"
    t(conn, translation_key)
  end

  def t(conn, key, opts) do
    t_result =
      case translate_field_or_create(conn, key) do
        nil -> key
        "" -> key
        result -> result
      end

    if opts[:plain], do: t_result, else: {:safe, t_result}
  end

  defp translate_field_or_create(conn, key) do
    if translation = translation_from_assigns(conn, key) do
      t_field(translation, :value, conn.assigns.current_locale)
    else
      create_translation(key)
    end
  end

  defp create_translation(key) do
    if Application.get_env(:shopix, :create_translations_on_front) do
      Front.Translation.changeset_create_key(key)
      |> Repo.insert()
    end

    nil
  end

  defp translation_from_assigns(conn, key) do
    conn.assigns.translations
    |> Enum.find(fn translation -> translation.key == key end)
  end
end
