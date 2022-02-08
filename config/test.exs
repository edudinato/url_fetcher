import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :url_fetcher, UrlFetcherWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+dk+7ONGH/pfdVnQkCv/BvfsCfodfsZ0yMAqIeUqcZEkrKg6bmoiyg+lIGhquZBu",
  server: false


# In test we don't send emails.
config :url_fetcher, UrlFetcher.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime


config :url_fetcher, :http_client, UrlFetcher.Http.ClientMock
