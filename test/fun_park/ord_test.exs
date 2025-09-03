defmodule FunPark.OrdTest do
  use FunPark.DataCase

  alias FunPark.Ord

  @moduletag :capture_log

  doctest Ord

  test "Chapter 3. Implement Order for FunPark Contexts" do
    assert Ord.lt?(1, 2)
    refute Ord.gt?(1, 2)
    assert Ord.ge?(2, 2)
    assert Ord.le?(2, 2)
  end
end
