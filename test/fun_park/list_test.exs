defmodule FunPark.ListTest do
  use FunPark.DataCase

  alias FunPark.List, as: FPList
  alias FunPark.Patron

  @moduletag :capture_log

  doctest FPList

  test "Chapter 2. Implement Domain-Specific Equality with Protocols" do
    # page 22
    patron_a = build(:patron)
    change_a = Patron.change(patron_a, %{ticket_tier: :premium})
    assert change_a.ticket_tier == :premium

    # change_a is filtered out because its considered the same as patron_a
    assert [^patron_a] = FPList.uniq([patron_a, change_a])

    # unions
    tea_cup = build(:ride, name: "Tea Cup")
    haunted_mansion = build(:ride, name: "Haunted Mansion")
    apple_cart = build(:ride, name: "Apple Cart")

    maintenance_log = [haunted_mansion, apple_cart]
    breakdown_log = [tea_cup, haunted_mansion]

    downtime_rides = FPList.union(maintenance_log, breakdown_log)
    assert tea_cup in downtime_rides
    assert haunted_mansion in downtime_rides
    assert apple_cart in downtime_rides

    # page 24
    # intersection
    long_wait = [haunted_mansion, apple_cart]
    most_fast_pass = [tea_cup, haunted_mansion]
    assert [^haunted_mansion] = FPList.intersection(long_wait, most_fast_pass)

    # difference
    accessible_rides = [haunted_mansion, apple_cart]
    restricted_rides = [haunted_mansion]

    assert [^apple_cart] = FPList.difference(accessible_rides, restricted_rides)

    # symmetric difference
    behaving_unexpectedly = FPList.symmetric_difference(long_wait, most_fast_pass)
    assert apple_cart in behaving_unexpectedly
    assert tea_cup in behaving_unexpectedly
    refute haunted_mansion in behaving_unexpectedly

    # page 25
    # All rides completed include all the fast_pass_rides
    banana_slip = build(:ride, name: "Banana Slip")
    fast_pass_rides = [tea_cup, banana_slip]
    rides_completed = [haunted_mansion, tea_cup, banana_slip]
    assert FPList.subset?(fast_pass_rides, rides_completed)

    # page 26
    # rides completed includes more than just the fast_pass_rides
    fast_pass_rides = [haunted_mansion]
    rides_completed = [tea_cup, banana_slip, haunted_mansion]
    assert FPList.superset?(rides_completed, fast_pass_rides)
  end
end
