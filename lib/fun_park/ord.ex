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
