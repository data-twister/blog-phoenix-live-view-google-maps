defmodule LiveViewGoogleMaps.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveViewGoogleMapsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveViewGoogleMaps.PubSub},
      # Start the Registry
     {Registry, keys: :unique, name: :maps},
      # Start the Endpoint (http/https)
      LiveViewGoogleMapsWeb.Endpoint
      # Start a worker by calling: LiveViewGoogleMaps.Worker.start_link(arg)
      # {LiveViewGoogleMaps.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewGoogleMaps.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiveViewGoogleMapsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
