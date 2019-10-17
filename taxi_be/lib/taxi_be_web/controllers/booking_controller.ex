defmodule TaxiBeWeb.BookingController do
use TaxiBeWeb, :controller

    def create(conn, %{"pickup_address" => pickup_address, "dropoff_address" => dropoff_address}) do

        coord1 = TaxiBeWeb.Geolocation.geocode(pickup_address)
        |> IO.inspect
        coord2 = TaxiBeWeb.Geolocation.geocode(dropoff_address)
        |> IO.inspect

        {distance,_} = TaxiBeWeb.Geolocation.distance_and_duration(coord1, coord2)
        IO.inspect "Ride fare: #{Float.ceil(distance/100)}"

        json(conn, %{msg: "We are working hard to serve your request"})
    end
end