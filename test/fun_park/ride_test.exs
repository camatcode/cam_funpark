defmodule FunPark.RideTest do
  use FunPark.DataCase

  alias FunPark.Eq
  alias FunPark.Ord
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

  test "Chapter 2. Implement Equality for FunPark Contexts" do
    # page 15
    ride_a = build(:ride)
    ride_b = Ride.change(ride_a, %{wait_time: 20})
    assert ride_b.wait_time == 20
    refute ride_a == ride_b
    assert Eq.eq?(ride_a, ride_b)
    refute Eq.not_eq?(ride_a, ride_b)
  end

  test "Chapter 3. Create Flexible Ordering with Protocols" do
    banana_slip = build(:ride, id: 1, name: "Banana Slip")
    apple_cart = build(:ride, name: "Apple Cart")

    refute apple_cart < banana_slip
    assert Ord.lt?(apple_cart, banana_slip)
  end

  test "Define your own Rides" do
    random_rides = build_list(1000, :ride)
    refute Enum.empty?(random_rides)

    assert Enum.each(random_rides, fn
             random_ride ->
               assert %Ride{} = random_ride
               assert random_ride.id
               assert random_ride.name
               assert random_ride.min_age
               assert random_ride.min_height
               refute is_nil(random_ride.online)
               assert random_ride.tags
           end)
  end
end
