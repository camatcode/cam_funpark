defmodule FunPark.FastPass do
  @moduledoc false

  alias __MODULE__, as: FastPass
  alias FunPark.Eq
  alias FunPark.Ride

  defstruct [:id, :ride, :time]

  def make(%FastPass{} = fp), do: fp

  def make(%{ride: ride, time: time} = m) when is_map(m) do
    make(ride, time)
  end

  def make(%Ride{} = ride, %DateTime{} = time) do
    %FastPass{
      id: System.monotonic_time() |> abs(),
      ride: ride,
      time: time
    }
  end

  def change(%FastPass{} = pass, %{} = attrs) do
    Map.delete(attrs, :id)
    |> then(&struct(pass, &1))
  end

  def get_time(%FastPass{} = pass), do: pass.time
  def get_ride(%FastPass{ride: ride}), do: ride

  def valid?(%FastPass{} = pass, %Ride{} = ride) do
    Eq.Utils.eq?(get_ride(pass), ride)
  end

  def duplicate_pass, do: Eq.Utils.concat_any([Eq, eq_ride_and_time()])
  def eq_time, do: Eq.Utils.contramap(&get_time/1)
  def eq_ride, do: Eq.Utils.contramap(&get_ride/1)
  def eq_ride_and_time, do: Eq.Utils.concat_all([eq_ride(), eq_time()])
end
