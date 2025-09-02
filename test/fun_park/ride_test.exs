defmodule FunPark.RideTest do
  use FunPark.DataCase

  alias FunPark.Ride

  @moduletag :capture_log

  doctest Ride

  test "Define the Ride Model" do
    # pg 3
    name = "Tea Cup"
    min_age = min_height = 0
    wait_time = 10
    online = true
    tags = [:family_friendly]

    assert %Ride{
             name: ^name,
             min_age: ^min_age,
             min_height: ^min_height,
             wait_time: ^wait_time,
             online: ^online,
             tags: ^tags
           } = Ride.make("Tea Cup", wait_time: 10, tags: tags)

    # pg 3 - 4
    assert %Ride{
             name: "Dark Mansion",
             min_age: 14,
             tags: [:dark]
           } = Ride.make("Dark Mansion", min_age: 14, tags: [:dark])
  end

  test "Define your own Rides" do
    random_ride = build(:ride)
    assert %Ride{} = random_ride
    assert random_ride.id
    assert random_ride.name
    assert random_ride.min_age
    assert random_ride.min_height
    refute is_nil(random_ride.online)
    assert random_ride.tags
  end
end
