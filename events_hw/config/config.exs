# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :events_hw,
  ecto_repos: [EventsHw.Repo]

# Configures the endpoint
config :events_hw, EventsHwWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7+20UEFfJX+Os9rJ0lH+0pxepw1EVRDUMFebyPE9T7kA7l9KAZAO3b6n1HXLhyzQ",
  render_errors: [view: EventsHwWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EventsHw.PubSub,
  live_view: [signing_salt: "OcUouFyu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
