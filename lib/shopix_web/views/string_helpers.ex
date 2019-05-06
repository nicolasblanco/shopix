defmodule ShopixWeb.StringHelpers do
  import Phoenix.HTML

  def to_json(data) do
    data
    |> Jason.encode!()
    |> raw
  end

  def options_reject_nil(options) do
    options
    |> Enum.reject(&is_nil(elem(&1, 1)))
  end

  def truncate(text, opts \\ []) do
    max_length = opts[:max_length] || 50
    omission = opts[:omission] || "..."

    cond do
      not String.valid?(text) ->
        text

      String.length(text) < max_length ->
        text

      true ->
        length_with_omission = max_length - String.length(omission)

        "#{String.slice(text, 0, length_with_omission)}#{omission}"
    end
  end
end
