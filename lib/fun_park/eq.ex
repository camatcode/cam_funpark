defprotocol FunPark.Eq do
  @moduledoc false

  @fallback_to_any true

  def eq?(a, b)

  def not_eq?(a, b)
end

defimpl FunPark.Eq, for: Any do
  def eq?(a, b), do: a == b
  def not_eq?(a, b), do: a != b
end

defimpl FunPark.Eq, for: FunPark.Patron do
  alias FunPark.Eq
  alias FunPark.Patron

  def eq?(%Patron{id: v1}, %Patron{id: v2}), do: Eq.eq?(v1, v2)
  def not_eq?(%Patron{id: v1}, %Patron{id: v2}), do: Eq.not_eq?(v1, v2)
end

defimpl FunPark.Eq, for: FunPark.Ride do
  alias FunPark.Eq
  alias FunPark.Ride

  def eq?(%Ride{id: v1}, %Ride{id: v2}), do: Eq.eq?(v1, v2)
  def not_eq?(%Ride{id: v1}, %Ride{id: v2}), do: Eq.not_eq?(v1, v2)
end

defimpl FunPark.Eq, for: FunPark.FastPass do
  alias FunPark.Eq
  alias FunPark.FastPass

  def eq?(%FastPass{id: v1}, %FastPass{id: v2}), do: Eq.eq?(v1, v2)
  def not_eq?(%FastPass{id: v1}, %FastPass{id: v2}), do: Eq.not_eq?(v1, v2)
end
