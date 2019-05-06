defmodule ShopixWeb.AdminGuardianPipeline do
  use Guardian.Plug.Pipeline, otp_app: :shopix,
                              module: Shopix.Guardian,
                              error_handler: ShopixWeb.AuthErrorHandler,
                              key: :admin

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
