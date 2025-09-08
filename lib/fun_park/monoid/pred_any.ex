defmodule FunPark.Monoid.Predicate.Any do
  @moduledoc false
  alias __MODULE__, as: PredicateAny

  defstruct value: &PredicateAny.default_pred?/1

  def default_pred?(_), do: false
end
