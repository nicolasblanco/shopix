defmodule Shopix.Admin.Statistics do
  import Ecto.Query
  use Timex

  alias Shopix.Schema.Order
  alias Shopix.Schema.User
  alias Shopix.Repo

  def orders_today_count do
    from(o in Order, select: count(o.id), where: fragment("?::date", o.completed_at) == ^Timex.today())
    |> Repo.one
  end

  def orders_this_week_count do
    from(o in Order, select: count(o.id), where: fragment("?::date", o.completed_at) >= ^(Timex.today |> Timex.beginning_of_week))
    |> Repo.one
  end

  def orders_this_month_count do
    from(o in Order, select: count(o.id), where: fragment("?::date", o.completed_at) >= ^(Timex.today |> Timex.beginning_of_month))
    |> Repo.one
  end

  def users_count do
    from(u in User, select: count(u.id))
    |> Repo.one
  end
end
