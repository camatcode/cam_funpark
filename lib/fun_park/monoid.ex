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

defimpl FunPark.Monoid, for: FunPark.Monoid.Eq.Any do
  alias FunPark.Eq.Utils
  alias FunPark.Monoid.Eq.Any

  def identity(_), do: %Any{}

  def append(%Any{} = eq1, %Any{} = eq2) do
    %Any{
      eq?: fn a, b -> eq1.eq?.(a, b) || eq2.eq?.(a, b) end,
      not_eq?: fn a, b -> eq1.not_eq?.(a, b) && eq2.not_eq?.(a, b) end
    }
  end

  def wrap(%Any{}, eq) do
    eq = Utils.to_eq_map(eq)

    %Any{eq?: eq.eq?, not_eq?: eq.not_eq?}
  end

  def unwrap(%Any{eq?: eq?, not_eq?: not_eq?}) do
    %{eq?: eq?, not_eq?: not_eq?}
  end
end

defimpl FunPark.Monoid, for: FunPark.Monoid.Ord do
  alias FunPark.Monoid.Ord
  alias FunPark.Ord.Utils

  def identity(_), do: %Ord{}

  def append(%Ord{} = ord1, %Ord{} = ord2) do
    %Ord{
      lt?: fn a, b ->
        cond do
          ord1.lt?.(a, b) -> true
          ord1.gt?.(a, b) -> false
          true -> ord2.lt?.(a, b)
        end
      end,
      le?: fn a, b ->
        cond do
          ord1.lt?.(a, b) -> true
          ord1.gt?.(a, b) -> false
          true -> ord2.le?.(a, b)
        end
      end,
      gt?: fn a, b ->
        cond do
          ord1.gt?.(a, b) -> true
          ord1.lt?.(a, b) -> false
          true -> ord2.gt?.(a, b)
        end
      end,
      ge?: fn a, b ->
        cond do
          ord1.gt?.(a, b) -> true
          ord1.lt?.(a, b) -> false
          true -> ord2.ge?.(a, b)
        end
      end
    }
  end

  def wrap(%Ord{}, ord) do
    ord = Utils.to_ord_map(ord)

    %Ord{
      lt?: ord.lt?,
      le?: ord.le?,
      gt?: ord.gt?,
      ge?: ord.ge?
    }
  end

  def unwrap(%Ord{lt?: lt?, le?: le?, gt?: gt?, ge?: ge?}) do
    %Ord{
      lt?: lt?,
      le?: le?,
      gt?: gt?,
      ge?: ge?
    }
  end
end

defimpl FunPark.Monoid, for: FunPark.Monoid.Max do
  alias FunPark.Monoid.Max
  alias FunPark.Ord.Utils

  def identity(%Max{value: min_value, ord: ord}), do: %Max{value: min_value, ord: ord}

  def append(%Max{value: a, ord: ord}, %Max{value: b}), do: %Max{value: Utils.max(a, b, ord), ord: ord}

  def wrap(%Max{ord: ord}, value), do: %Max{value: value, ord: Utils.to_ord_map(ord)}

  def unwrap(%Max{value: value}), do: value
end
