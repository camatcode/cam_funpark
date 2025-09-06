defmodule FunPark.MonoidTest do
  use ExUnit.Case

  alias FunPark.Monoid
  alias FunPark.Monoid.Sum

  @moduletag :capture_log

  doctest Monoid

  test "Chapter 4. Combine with Monoids" do
    sum_1 = Monoid.wrap(%Sum{}, 1)
    sum_2 = Monoid.wrap(%Sum{}, 2)
    assert %Sum{value: 1} == sum_1
    assert %Sum{value: 2} == sum_2
    value = Monoid.append(sum_1, sum_2)
    assert %Sum{value: 3} == value
    assert 3 == Monoid.unwrap(value)
    # page 49
    assert 3 == Monoid.Utils.m_append(%Sum{}, 1, 2)
  end

  #  test "foo" do
  #    {result, _exit} = System.cmd("stat", ["/home/cam/hello"])
  #
  #    %{"Birth" => birth} =
  #      result
  #      |> String.split("\n")
  #      |> Enum.reject(&(&1 == ""))
  #      |> Map.new(fn line ->
  #        [key, value] =
  #          line
  #          |> String.trim()
  #          |> String.split(":", parts: 2)
  #
  #        {key, value |> String.trim()}
  #      end)
  #
  #    assert "2025-09-06 10:12:29.200959233 -0400" == birth
  #
  #    IO.inspect(birth)
  #  end
end
