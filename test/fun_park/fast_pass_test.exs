defmodule FunPark.FastPassTest do
  use FunPark.DataCase

  alias FunPark.Eq
  alias FunPark.FastPass

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
end
