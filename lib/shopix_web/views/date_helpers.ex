defmodule ShopixWeb.DateHelpers do
  def datetime_format(%{default_timezone: default_timezone}, datetime) do
    Timex.Timezone.convert(datetime, default_timezone)
    |> Timex.format!("%d/%m/%Y %H:%M", :strftime)
  end
end
