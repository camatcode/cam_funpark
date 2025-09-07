defmodule FunPark.Monoid.Ord do
  @moduledoc false

  alias __MODULE__, as: Ord

  defstruct lt?: &Ord.default?/2, le?: &Ord.default?/2, gt?: &Ord.default?/2, ge?: &Ord.default?/2

  def default?(_, _), do: false
end
