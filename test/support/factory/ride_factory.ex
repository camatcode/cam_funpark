defmodule FunPark.Factory.RideFactory do
  @moduledoc false
  use ExMachina

  defmacro __using__(_opts) do
    quote do
      alias FunPark.Ride

      def ride_factory do
        ride_tags = [:dark, :family_friendly]

        %{
          name: Faker.Lorem.words(2) |> Enum.join(" "),
          min_age: Enum.random(0..10),
          min_height: Enum.random(0..200),
          wait_time: Enum.random(0..5000),
          online: Enum.random([true, false]),
          tags:
            0..Enum.random(0..10)
            |> Enum.map(fn _ -> Enum.random(ride_tags) end)
            |> Enum.uniq()
        }
        |> Ride.make()
      end
    end
  end
end
