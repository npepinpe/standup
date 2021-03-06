# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :standup,
  ecto_repos: [Standup.Repo]

# Configures the endpoint
config :standup, Standup.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BABwPZmzCNOoo2MNxYpCL7J5tLPCpPt24i8dBHcS0uxpJw3Q72+qTzVgexrZZNhF",
  render_errors: [view: Standup.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Standup.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures redis
config :standup, Standup.Redis,
  redis: [
    {:host, String.to_char_list("127.0.0.1")},
    {:port, 6379}
  ],
  pool: [
    {:name, {:local, :redis_pool}},
    {:worker_module, :eredis},
    {:size, 5},
    {:max_overflow, 10}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
