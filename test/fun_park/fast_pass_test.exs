defmodule FunPark.FastPassTest do
  use FunPark.DataCase

  alias FunPark.Eq
  alias FunPark.FastPass
  alias FunPark.Ord
  alias FunPark.Patron
  alias FunPark.Ride

  @moduletag :capture_log

  doctest FastPass

  test "Build FunPark, Model Real-World Data" do
    ride = build(:ride)
    date_time = Faker.DateTime.backward(1)

    %FastPass{
      id: _id,
      ride: ^ride,
      time: ^date_time
    } = FastPass.make(ride, date_time)
  end

  test "Chapter 2. Implement Domain-Specific Equality with Protocols" do
    # page 16 - 17
    ride = build(:ride)
    date_time = Faker.DateTime.backward(1)
    fast_pass_a = FastPass.make(ride, date_time)

    new_ride = build(:ride)
    fast_pass_b = FastPass.change(fast_pass_a, %{ride: new_ride})

    refute fast_pass_a == fast_pass_b
    assert Eq.eq?(fast_pass_a, fast_pass_b)
    refute Eq.not_eq?(fast_pass_a, fast_pass_b)

    # page 18 - 19
    dark_mansion = build(:ride, name: "Dark Mansion")
    tea_cup = build(:ride, name: "Tea Cup")
    date_time = Faker.DateTime.backward(1)

    fast_pass_a = FastPass.make(dark_mansion, date_time)
    fast_pass_b = FastPass.make(tea_cup, date_time)

    refute Eq.eq?(fast_pass_a, fast_pass_b)

    # both passes are functionally equivalent because they exist at the same time.
    assert FastPass.eq_time().eq?.(fast_pass_a, fast_pass_b)

    # page 21
    dark_mansion = build(:ride, name: "Dark Mansion")
    tea_cup = build(:ride, name: "Tea Cup")
    date_time = Faker.DateTime.backward(1)

    fast_pass_a = FastPass.make(dark_mansion, date_time)
    fast_pass_b = FastPass.make(tea_cup, date_time)

    # they have different ids, from this default perspective, they are different
    refute Eq.Utils.eq?(fast_pass_a, fast_pass_b)

    # they have the same time, with eq_time/0 func logic, they're assessed as the same
    has_eq_time = FastPass.eq_time()
    assert Eq.Utils.eq?(fast_pass_a, fast_pass_b, has_eq_time)
  end

  test "Chapter 3. Implement Order for FunPark Contexts" do
    # page 34
    apple_cart = build(:ride, name: "Apple Cart")
    banana_slip = build(:ride, name: "Banana Slip")

    datetime_1 = Faker.DateTime.backward(1)
    datetime_2 = Faker.DateTime.forward(1)

    fast_pass_1 = build(:fast_pass, ride: banana_slip, time: datetime_1)
    fast_pass_2 = build(:fast_pass, ride: apple_cart, time: datetime_2)

    assert Ord.lt?(fast_pass_1, fast_pass_2)

    datetime_3 = Faker.DateTime.forward(100)
    fast_pass_1 = FastPass.change(fast_pass_1, %{time: datetime_3})
    assert Ord.gt?(fast_pass_1, fast_pass_2)
  end

  test "Chapter 4. Combine Equality" do
    # page 53
    datetime = Faker.DateTime.forward(1)
    apple = build(:ride, name: "Apple")
    fast_pass_a = build(:fast_pass, ride: apple, time: datetime)
    fast_pass_b = build(:fast_pass, ride: apple, time: datetime)

    eq_ride = FastPass.eq_ride()
    eq_time = FastPass.eq_time()
    eq_both = Eq.Utils.concat_all([eq_ride, eq_time])

    refute Eq.Utils.eq?(fast_pass_a, fast_pass_b)
    assert Eq.Utils.eq?(fast_pass_a, fast_pass_b, eq_ride)
    assert Eq.Utils.eq?(fast_pass_a, fast_pass_b, eq_time)
    assert Eq.Utils.eq?(fast_pass_a, fast_pass_b, eq_both)

    datetime_2 = Faker.DateTime.backward(1)
    fast_pass_a = FastPass.change(fast_pass_a, %{time: datetime_2})
    assert Eq.Utils.eq?(fast_pass_a, fast_pass_b, eq_ride)
    refute Eq.Utils.eq?(fast_pass_a, fast_pass_b, eq_time)
    refute Eq.Utils.eq?(fast_pass_a, fast_pass_b, eq_both)

    # page 55 - 56
    datetime = Faker.DateTime.forward(1)
    tea_cup = build(:ride, name: "Tea Cup")
    pass_a = build(:fast_pass, time: datetime, ride: tea_cup)
    pass_b = build(:fast_pass, time: datetime, ride: tea_cup)

    refute Eq.Utils.eq?(pass_a, pass_b)
    dup_pass_check = FastPass.duplicate_pass()
    assert Eq.Utils.eq?(pass_a, pass_b, dup_pass_check)

    mansion = build(:ride, name: "Haunted Mansion")
    pass_a_changed = FastPass.change(pass_a, %{ride: mansion})
    assert Eq.Utils.eq?(pass_a, pass_a_changed, dup_pass_check)
    refute Eq.Utils.eq?(pass_b, pass_a_changed, dup_pass_check)
  end

  test "Chapter 5" do
    # page 87
    fast_pass = build(:fast_pass)

    alice =
      build(:patron, name: "Alice")
      |> Patron.add_fast_pass(fast_pass)

    assert Ride.fast_pass?(alice, fast_pass.ride)

    # page 89 - 90
    haunted_mansion = Ride.make("Haunted Mansion", min_age: 14, min_height: 1)
    fast_pass = build(:fast_pass, ride: haunted_mansion)
    alice = build(:patron, name: "Alice", age: 13, height: 150, fast_passes: [fast_pass])
    beth = build(:patron, name: "Beth", age: 15, height: 110)

    refute Ride.fast_pass_lane?(alice, haunted_mansion)
    refute Ride.fast_pass_lane?(beth, haunted_mansion)

    beth = Patron.change(beth, %{ticket_tier: :vip})
    assert Ride.fast_pass_lane?(beth, haunted_mansion)
  end
end
