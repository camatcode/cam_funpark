defprotocol FunPark.Monoid do
  @moduledoc false

  # returns the identity element, leaves the value unchanged
  def identity(monoid_struct)
  # combines two values in an associative way
  def append(monoid_struct_a, monoid_struct_b)
  # puts the value in the struct
  def wrap(monoid_struct, value)
  # gets the value out of the struct
  def unwrap(monoid_struct)
end

defimpl FunPark.Monoid, for: FunPark.Monoid.Eq.All do
  alias FunPark.Eq.Utils
  alias FunPark.Monoid.Eq.All

  def identity(_), do: %All{}

  def append(%All{} = eq1, %All{} = eq2) do
    %All{
      eq?: fn a, b -> eq1.eq?.(a, b) && eq2.eq?.(a, b) end,
      not_eq?: fn a, b -> eq1.not_eq?.(a, b) && eq2.not_eq?.(a, b) end
    }
  end

  def wrap(%All{}, eq) do
    eq = Utils.to_eq_map(eq)

    %All{eq?: eq.eq?, not_eq?: eq.not_eq?}
  end

  def unwrap(%All{eq?: eq?, not_eq?: not_eq?}) do
    %{eq?: eq?, not_eq?: not_eq?}
  end
end
