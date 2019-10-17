defmodule TaxiBe.Repo do
  use Ecto.Repo,
    otp_app: :taxi_be,
    adapter: Ecto.Adapters.Postgres
end
