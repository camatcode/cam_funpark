defmodule FunPark.FastPass do
  @moduledoc false

  alias __MODULE__, as: FastPass
  alias FunPark.Ride

  defstruct [:id, :ride, :time]

  def make(%Ride{} = ride, %DateTime{} = time) do
    %FastPass{
      id: :erlang.unique_integer([:positive, :monotonic]),
      ride: ride,
      time: time
    }
  end
end
