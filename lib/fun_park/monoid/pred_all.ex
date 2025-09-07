defmodule FunPark.Monoid.Predicate.All do
  @moduledoc false
  alias __MODULE__, as: PredicateAll

  defstruct value: &PredicateAll.default_pred?/1

  def default_pred?(_), do: true
end
