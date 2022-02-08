defmodule UrlFetcher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UrlFetcherWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: UrlFetcher.PubSub},
      # Start the Endpoint (http/https)
      UrlFetcherWeb.Endpoint
      # Start a worker by calling: UrlFetcher.Worker.start_link(arg)
      # {UrlFetcher.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UrlFetcher.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UrlFetcherWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
