defmodule FunPark.Factory do
  @moduledoc false
  use ExMachina
  use FunPark.Factory.RideFactory
  use FunPark.Factory.PatronFactory
  use FunPark.Factory.FastPassFactory
end
