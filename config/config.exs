# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :comfort_mail,
  ecto_repos: [ComfortMail.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :comfort_mail, ComfortMailWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ComfortMailWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ComfortMail.PubSub,
  live_view: [signing_salt: "wiGvs2TM"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :comfort_mail, ComfortMail.Mailer, adapter: Swoosh.Adapters.Local
config :comfort_mail, ComfortMail.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.strato.de",
  username: "no-reply@comfort-mail.com",
  password: "wrong_password_for_now_use_secrets",
  tls: :always,
  auth: :always,
  port: 587,
  retries: 2

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
