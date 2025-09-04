defmodule FunPark.RideTest do
  use FunPark.DataCase

  alias FunPark.Eq
  alias FunPark.List, as: FPList
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

    assert :eq == Ord.Utils.compare(apple_cart, apple_cart)
    assert :lt == Ord.Utils.compare(apple_cart, banana_slip)
    assert :gt == Ord.Utils.compare(banana_slip, apple_cart)

    # page 39
    assert [apple_cart, banana_slip] == FPList.sort([banana_slip, apple_cart])

    # page 40
    tea_cup = build(:ride, name: "Tea Cup", wait_time: 40)
    haunted_mansion = build(:ride, name: "Haunted Mansion", wait_time: 20)
    river_ride = build(:ride, name: "River Ride", wait_time: 40)
    rides = [tea_cup, haunted_mansion, river_ride]
    ord_wait_time = Ride.ord_by_wait_time()
    assert [haunted_mansion, tea_cup, river_ride] == FPList.sort(rides, ord_wait_time)
    assert [haunted_mansion, tea_cup] == FPList.strict_sort(rides, ord_wait_time)
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
