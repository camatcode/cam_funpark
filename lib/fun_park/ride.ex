defmodule FunPark.Ride do
  @moduledoc false

  alias __MODULE__, as: Ride
  alias FunPark.Ord

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

  def ord_by_wait_time do
    Ord.Utils.contramap(&get_wait_time/1)
  end
end
