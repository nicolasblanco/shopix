defmodule Shopix.LocalizedCountries do
  def countries(locale) do
    [Application.app_dir(:shopix, "priv"), "locales", "#{locale}.yml"]
    |> Path.join()
    |> YamlElixir.read_from_file!()
    |> Map.fetch!(locale)
    |> Map.fetch!("countries")
    |> Enum.sort()
    |> Enum.map(fn {key, value} -> {String.to_atom(value), key} end)
  end
end
