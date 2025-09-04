defprotocol FunPark.Ord do
  @moduledoc false
  @fallback_to_any true

  def lt?(a, b)
  def le?(a, b)
  def gt?(a, b)
  def ge?(a, b)
end

defimpl FunPark.Ord, for: Any do
  def lt?(a, b), do: a < b
  def le?(a, b), do: a <= b
  def gt?(a, b), do: a > b
  def ge?(a, b), do: a >= b
end

defimpl FunPark.Ord, for: FunPark.Ride do
  alias FunPark.Ord
  alias FunPark.Ride

  def lt?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.lt?(v1, v2)
  def le?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.le?(v1, v2)
  def gt?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.gt?(v1, v2)
  def ge?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.ge?(v1, v2)
end

defimpl FunPark.Ord, for: FunPark.FastPass do
  alias FunPark.FastPass
  alias FunPark.Ord

  def lt?(%FastPass{time: v1}, %FastPass{time: v2}), do: DateTime.before?(v1, v2)
  def le?(%FastPass{time: v1}, %FastPass{time: v2}), do: match?(x when x in [:lt, :eq], DateTime.compare(v1, v2))
  def gt?(%FastPass{time: v1}, %FastPass{time: v2}), do: DateTime.after?(v1, v2)
  def ge?(%FastPass{time: v1}, %FastPass{time: v2}), do: match?(x when x in [:gt, :eq], DateTime.compare(v1, v2))
end
