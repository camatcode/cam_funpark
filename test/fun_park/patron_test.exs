defmodule FunPark.PatronTest do
  use FunPark.DataCase

  alias FunPark.Eq
  alias FunPark.FastPass
  alias FunPark.Patron
  alias FunPark.Ride

  @moduletag :capture_log

  doctest Patron

  test "Chapter 1. Build FunPark: Model Real-World Data" do
    ride = Ride.make("Dark Mansion", min_age: 14, tags: [:dark])
    date_time = Faker.DateTime.backward(1)

    fast_pass = FastPass.make(ride, date_time)
    name = "Alice"
    age = 15
    height = 120

    assert %Patron{
             name: ^name,
             age: ^age,
             height: ^height,
             ticket_tier: :basic,
             fast_passes: [^fast_pass]
           } = Patron.make(name, age, height, fast_passes: [fast_pass])
  end

  test "Chapter 2. Implement Domain-Specific Equality with Protocols" do
    # page 12 - 13
    to_change = build(:patron)
    changed = Patron.change(to_change, %{ticket_tier: :premium})
    refute to_change == changed
    assert changed.ticket_tier == :premium

    assert Eq.eq?(to_change, changed)
    refute Eq.not_eq?(to_change, changed)
  end

  test "Chapter 3. Create Flexible Ordering with Protocols" do
    # page 36
    alice = build(:patron, name: "Alice", ticket_tier: :premium)
    beth = build(:patron, name: "Beth", ticket_tier: :basic)

    ticket_ord = Patron.ord_by_ticket_tier()
    assert ticket_ord.gt?.(alice, beth)

    beth = Patron.change(beth, %{ticket_tier: :vip})
    assert ticket_ord.gt?.(beth, alice)
  end

  test "Chapter 4. Combine with Monoids" do
    # page 64 - 65
    alice = build(:patron, name: "Alice", ticket_tier: :basic, reward_points: 0)
    beth = build(:patron, name: "Beth", ticket_tier: :basic, reward_points: 100)
    assert beth == Patron.highest_priority([alice, beth])
    alice = Patron.change(alice, %{ticket_tier: :vip})
    assert alice == Patron.highest_priority([alice, beth])
    assert beth == Patron.highest_priority([beth])

    sentinel = %FunPark.Patron{
      id: nil,
      name: nil,
      age: 0,
      height: 0,
      ticket_tier: nil,
      fast_passes: [],
      reward_points: Float.min_finite(),
      likes: [],
      dislikes: []
    }

    assert sentinel == Patron.highest_priority([])
  end
end
