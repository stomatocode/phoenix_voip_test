defmodule PhoenixVoipTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixVoipTestWeb.Telemetry,
      PhoenixVoipTest.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_voip_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixVoipTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixVoipTest.Finch},
      # Start a worker by calling: PhoenixVoipTest.Worker.start_link(arg)
      # {PhoenixVoipTest.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixVoipTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixVoipTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixVoipTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
