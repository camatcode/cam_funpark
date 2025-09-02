defmodule FunPark.FastPassTest do
  use ExUnit.Case

  alias FunPark.FastPass
  alias FunPark.Ride

  @moduletag :capture_log

  doctest FastPass

  test "Build FunPark, Model Real-World Data" do
    ride = Ride.make("Dark Mansion", min_age: 14, tags: [:dark])
    date_time = Faker.DateTime.backward(1)

    %FastPass{
      id: _id,
      ride: ^ride,
      time: ^date_time
    } = FastPass.make(ride, date_time)
  end
end
