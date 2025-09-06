defmodule FunPark.Monoid.Eq.Any do
  @moduledoc false

  alias __MODULE__, as: EqAny

  defstruct eq?: &EqAny.default_eq?/2, not_eq?: &EqAny.default_not_eq?/2

  def default_eq?(_, _), do: false
  def default_not_eq?(_, _), do: true
end
