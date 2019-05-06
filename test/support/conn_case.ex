defmodule ShopixWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import ShopixWeb.Router.Helpers
      import Shopix.Factory

      alias Shopix.Guardian

      # The default endpoint for testing
      @endpoint ShopixWeb.Endpoint

      def guardian_login(user, key \\ :admin) do
        insert(:global_config)

        build_conn()
        |> bypass_through(ShopixWeb.Router, [:browser])
        |> get("/")
        |> Guardian.Plug.sign_in(user, %{}, key: key)
        |> send_resp(200, "Flush the session yo")
        |> recycle()
      end

      def put_global_config(conn) do
        conn
        |> Plug.Conn.assign(:global_config, %Shopix.Schema.GlobalConfig{})
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Shopix.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Shopix.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
