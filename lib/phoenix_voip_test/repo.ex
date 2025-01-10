defmodule PhoenixVoipTest.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_voip_test,
    adapter: Ecto.Adapters.Postgres
end
