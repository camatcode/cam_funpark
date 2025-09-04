defmodule FunPark.OrdTest do
  use FunPark.DataCase

  alias FunPark.Ord

  @moduletag :capture_log

  doctest Ord

  test "Chapter 3. Implement Order for FunPark Contexts" do
    # page 31
    assert Ord.lt?(1, 2)
    refute Ord.gt?(1, 2)
    assert Ord.ge?(2, 2)
    assert Ord.le?(2, 2)

    # page 38
    assert :eq == Ord.Utils.compare(1, 1)
    assert :lt == Ord.Utils.compare(1, 2)
    assert :gt == Ord.Utils.compare(1, 0)
  end
end
