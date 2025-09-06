defmodule FunPark.Monoid.Ord do
  @moduledoc false

  alias __MODULE__, as: Ord

  defstruct lt?: &Ord.default?/2, le?: &Ord.default?/2, gt?: &Ord.default?/2, ge?: &Ord.default?/2

  def default?(_, _), do: false
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
