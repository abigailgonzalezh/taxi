defmodule TaxiBeWeb.Geolocation do

    @geocodingURL "https://api.mapbox.com/geocoding/v5/mapbox.places/"
    @token "pk.eyJ1IjoiYW5kcmVyZHo3IiwiYSI6ImNrMXMwZTBldDA0MnQzbHFtanc5MnMwNnEifQ.lzUc0gGUPfPgG-ktKXL1_A"
    @directionsURL "https://api.mapbox.com/directions/v5/mapbox/driving/" 
    def geocode(address) do
        %{body: body} = HTTPoison.get!(
            @geocodingURL <> 
            URI.encode(address) <>
            ".json?limit=1&access_token=" <> 
            @token)
        body
        |> Jason.decode!
        |> Map.fetch!("features")
        |> Enum.at(0)
        |> Map.fetch!("center")
        |> IO.inspect
    end

    def distance_and_duration(origin_coord, destination_coord) do
        %{body: body} = HTTPoison.get!(@directionsURL <> "#{Enum.join(origin_coord, ",")};#{Enum.join(destination_coord, ",")}"<> "?access_token=" <> @token)

        %{"duration" => duration, "distance" => distance} =
            body
            |> Jason.decode!
            |> Map.fetch!("routes")
            |> Enum.at(0)

        {distance, duration}
    end
end