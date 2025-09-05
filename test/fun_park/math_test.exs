defmodule FunPark.MathTest do
  use ExUnit.Case

  alias FunPark.Math

  @moduletag :capture_log

  doctest Math

  test "Chapter 4. Combine with Monoids" do
    assert 3 == Math.sum(1, 2)
    assert 6 == Math.sum([1, 2, 3])
    assert 3 == Math.sum([3])
    assert 0 == Math.sum([])
  end
end
