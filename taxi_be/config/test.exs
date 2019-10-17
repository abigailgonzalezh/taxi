use Mix.Config

# Configure your database
config :taxi_be, TaxiBe.Repo,
  username: "postgres",
  password: "postgres",
  database: "taxi_be_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :taxi_be, TaxiBeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
