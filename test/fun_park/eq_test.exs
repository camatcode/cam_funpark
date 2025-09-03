defmodule FunPark.EqTest do
  use ExUnit.Case

  alias FunPark.Eq

  @moduletag :capture_log

  doctest Eq

  test "Implement Equality for FunPark Contexts" do
    assert Eq.eq?(1, 1)
    refute Eq.eq?(1, 2)
  end
end
