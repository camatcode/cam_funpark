defmodule FunPark.Monoid.Eq.All do
  @moduledoc false

  alias __MODULE__, as: EqAll

  defstruct eq?: &EqAll.default_eq?/2, not_eq?: &EqAll.default_not_eq?/2

  def default_eq?(_, _), do: true
  def default_not_eq?(_, _), do: false
end
