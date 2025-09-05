defmodule FunPark.Monoid.Utils do
  @moduledoc false
  import FunPark.Foldable, only: [fold_l: 3]
  import FunPark.Monoid, only: [append: 2, wrap: 2, unwrap: 1, identity: 1]

  def m_append(monoid, a, b) when is_struct(monoid) do
    append(wrap(monoid, a), wrap(monoid, b))
    |> unwrap()
  end

  def m_concat(monoid, values) when is_struct(monoid) and is_list(values) do
    fold_l(values, identity(monoid), fn value, acc ->
      append(acc, wrap(monoid, value))
    end)
    |> unwrap()
  end
end
