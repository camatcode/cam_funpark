defmodule FunPark.FastPass do
  @moduledoc false

  alias __MODULE__, as: FastPass
  alias FunPark.Eq
  alias FunPark.Ride

  defstruct [:id, :ride, :time]

  def make(%Ride{} = ride, %DateTime{} = time) do
    %FastPass{
      id: :erlang.unique_integer([:positive, :monotonic]),
      ride: ride,
      time: time
    }
  end

  def change(%FastPass{} = pass, %{} = attrs) do
    Map.delete(attrs, :id)
    |> then(&struct(pass, &1))
  end

  def time(%FastPass{} = pass), do: pass.time

  def eq_time, do: Eq.Utils.contramap(&time/1)
end
