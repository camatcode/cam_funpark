defmodule FunPark.Monoid.Sum do
  @moduledoc false
  defstruct value: 0
end

defimpl FunPark.Monoid, for: FunPark.Monoid.Sum do
  alias FunPark.Monoid.Sum

  def identity(_), do: %Sum{}
  def append(%Sum{value: a}, %Sum{value: b}), do: %Sum{value: a + b}
  def wrap(%Sum{}, value) when is_number(value), do: %Sum{value: value}
  def unwrap(%Sum{value: value}) when is_number(value), do: value
end
