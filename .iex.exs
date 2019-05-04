import Ecto.Query

alias Decimal, as: D

alias Ecto.Changeset

alias Shopix.{Repo, Admin, Schema, Front, Mailer}
alias ShopixWeb.Email

use Timex
