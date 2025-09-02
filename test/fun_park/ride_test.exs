defmodule FunPark.RideTest do
  use ExUnit.Case

  alias FunPark.Ride

  @moduletag :capture_log

  doctest Ride

  test "Define the Ride Model" do
    # pg 3
    assert %Ride{
             name: "Tea Cup",
             min_age: 0,
             min_height: 0,
             wait_time: 10,
             online: true,
             tags: [:family_friendly]
           } = Ride.make("Tea Cup", wait_time: 10, tags: [:family_friendly])

    # pg 3 - 4
    dark_mansion =
      Ride.make("Dark Mansion", min_age: 14, tags: [:dark])

    assert %FunPark.Ride{
             name: "Dark Mansion",
             min_age: 14,
             tags: [:dark]
           } = dark_mansion
  end
end
