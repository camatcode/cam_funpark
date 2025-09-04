defmodule FunPark.OrdTest do
  use FunPark.DataCase

  alias FunPark.Ord
  alias FunPark.Ord.Utils

  @moduletag :capture_log

  doctest Ord

  test "Chapter 3. Implement Order for FunPark Contexts" do
    # page 31
    assert Ord.lt?(1, 2)
    refute Ord.gt?(1, 2)
    assert Ord.ge?(2, 2)
    assert Ord.le?(2, 2)

    # page 38
    assert :eq == Utils.compare(1, 1)
    assert :lt == Utils.compare(1, 2)
    assert :gt == Utils.compare(1, 0)

    # page 41
    reverse_ord = Utils.reverse()
    assert :lt == Utils.compare(:apple, :banana)
    assert :gt == Utils.compare(:apple, :banana, reverse_ord)
  end
end
