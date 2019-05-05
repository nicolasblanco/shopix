defmodule ShopixWeb.ImageHelpers do
  def image_url(data, index \\ 0)
  def image_url(%{images_group_url: nil}, _), do: "/img/logo.png"

  def image_url(%{images_group_url: images_group_url}, index) do
    "#{images_group_url}nth/#{index}/-/format/jpeg/image.jpg"
  end

  def thumb_url(data, index \\ 0)
  def thumb_url(%{images_group_url: nil}, _), do: "/img/logo.png"

  def thumb_url(%{images_group_url: images_group_url}, index) do
    "#{images_group_url}nth/#{index}/-/format/jpeg/-/preview/400x400/image.jpg"
  end

  def images_with_index(%{images_group_url: nil}) do
    [
      %{
        url: "/img/logo.png",
        thumb_url: "/img/logo.png",
        index: 0
      }
    ]
  end

  def images_with_index(%{} = data) do
    case Regex.run(~r/~(\d+)\/\z/, data.images_group_url) do
      [_, number_of_images] ->
        Enum.map(0..(String.to_integer(number_of_images) - 1), fn index ->
          %{
            url: image_url(data, index),
            thumb_url: thumb_url(data, index),
            index: index
          }
        end)

      nil ->
        nil
    end
  end
end
