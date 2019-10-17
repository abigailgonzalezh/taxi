defmodule TaxiBeWeb.Router do
  use TaxiBeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaxiBeWeb do
    pipe_through :api
    post "/bookings", BookingController, :create
  end
end
