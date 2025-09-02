defmodule FunPark.PatronTest do
  use ExUnit.Case

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
end
