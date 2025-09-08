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

  test "Chapter 5" do
    # page 72
    tea_cup = build(:ride, name: "Tea Cup", online: true, wait_time: 100)
    assert Ride.online?(tea_cup)
    assert Ride.long_wait?(tea_cup)

    # page 76
    refute Ride.suggested?(tea_cup)

    tea_cup = Ride.change(tea_cup, %{wait_time: 10})
    assert Ride.suggested?(tea_cup)

    # page 77
    roller_mtn = build(:ride, name: "Roller Mountain", min_height: 120, min_age: 12, online: true, wait_time: 10)
    alice = build(:patron, name: "Alice", age: 13, height: 119)

    assert Ride.old_enough?(alice, roller_mtn)
    refute Ride.tall_enough?(alice, roller_mtn)
    refute Ride.eligible?(alice, roller_mtn)

    alice = FunPark.Patron.change(alice, %{height: 121})
    assert Ride.eligible?(alice, roller_mtn)

    # page 80
    assert Ride.suggested?(alice, roller_mtn)
    roller_mtn = Ride.change(roller_mtn, %{online: false})
    refute Ride.suggested?(alice, roller_mtn)

    # page 81 -83
    thunder_loop = Ride.make("Thunder Loop")
    ghost_hollow = Ride.make("Ghost Hollow", online: false)
    rocket_ride = Ride.make("Rocket Ridge")
    jungle_river = Ride.make("Jungle River", online: false)
    nebula_falls = Ride.make("Nebula Falls")
    timber_twister = Ride.make("Timber Twister", online: false)

    rides = [thunder_loop, ghost_hollow, rocket_ride, jungle_river, nebula_falls, timber_twister]
    online? = &Ride.online?/1

    refute Enum.all?(rides, online?)
    assert Enum.any?(rides, online?)
    assert 3 == Enum.count(rides, online?)
    assert thunder_loop == Enum.find(rides, online?)
    assert 0 == Enum.find_index(rides, online?)
    assert [thunder_loop, rocket_ride, nebula_falls] == Enum.filter(rides, online?)
    assert [ghost_hollow, jungle_river, timber_twister] == Enum.reject(rides, online?)
    assert [thunder_loop] == Enum.take_while(rides, online?)
    assert tl(rides) == Enum.drop_while(rides, online?)

    assert {[thunder_loop], tl(rides)} == Enum.split_while(rides, online?)

    # page 84 - 85
    tea_cup = Ride.make("Tea Cup")
    roller_mtn = Ride.make("Roller Mountain", min_height: 120)
    haunted_mansion = Ride.make("Haunted Mansion", min_age: 14)
    rides = [tea_cup, roller_mtn, haunted_mansion]
    alice = build(:patron, name: "Alice", age: 13, height: 150)
    beth = build(:patron, name: "Beth", age: 15, height: 110)

    assert [tea_cup, roller_mtn] == Ride.suggested_rides(alice, rides)
    assert [tea_cup, haunted_mansion] == Ride.suggested_rides(beth, rides)

    tea_cup = Ride.change(tea_cup, %{wait_time: 40})
    rides = [tea_cup, roller_mtn, haunted_mansion]

    assert [haunted_mansion] == Ride.suggested_rides(beth, rides)
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
