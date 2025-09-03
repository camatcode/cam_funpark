defmodule FunPark.DataCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      import FunPark.DataCase
      import FunPark.Factory
    end
  end
end
