defmodule FunPark.Ride do
  @moduledoc false

  import FunPark.Predicate, only: [p_not: 1, p_all: 1]
  import FunPark.Utils

  alias __MODULE__, as: Ride
  alias FunPark.Ord
  alias FunPark.Patron

  defstruct [
    :id,
    name: "Unknown Ride",
    min_age: 0,
    min_height: 0,
    wait_time: 0,
    online: true,
    tags: []
  ]

  def make(%Ride{} = r), do: r

  def make(m) when is_map(m) do
    opts = Enum.map(m, fn {key, value} -> {key, value} end)
    name = Map.get(m, :name)
    make(name, opts)
  end

  def make(name, opts \\ []) when is_binary(name) do
    %Ride{
      id: System.monotonic_time() |> abs(),
      name: name,
      min_age: Keyword.get(opts, :min_age, 0),
      min_height: Keyword.get(opts, :min_height, 0),
      wait_time: Keyword.get(opts, :wait_time, 0),
      online: Keyword.get(opts, :online, true),
      tags: Keyword.get(opts, :tags, [])
    }
  end

  def change(%Ride{} = ride, %{} = attrs) do
    Map.delete(attrs, :id)
    |> then(&struct(ride, &1))
  end

  def get_wait_time(%Ride{wait_time: wait_time}), do: wait_time

  def online?(%Ride{online: online}), do: online

  def long_wait?(%Ride{wait_time: wait_time}), do: wait_time > 30

  def short_wait?, do: p_not(&long_wait?/1)

  def suggested?(%Ride{} = ride), do: p_all([&online?/1, p_not(&long_wait?/1)]).(ride)

  def suggested?(%Patron{} = patron, %Ride{} = ride) do
    p_all([&suggested?/1, curry(&eligible?/2).(patron)]).(ride)
  end

  def suggested_rides(%Patron{} = patron, rides) when is_list(rides) do
    Enum.filter(rides, &suggested?(patron, &1))
  end

  def ord_by_wait_time, do: Ord.Utils.contramap(&get_wait_time/1)

  def tall_enough?(%Patron{} = patron, %Ride{min_height: min_height}) do
    Patron.get_height(patron) >= min_height
  end

  def old_enough?(%Patron{} = patron, %Ride{min_age: min_age}) do
    Patron.get_age(patron) >= min_age
  end

  def eligible?(%Patron{} = patron, %Ride{} = ride) do
    p_all([curry(&tall_enough?/2).(patron), curry(&old_enough?/2).(patron)]).(ride)
  end
end
