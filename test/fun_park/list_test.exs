defmodule FunPark.ListTest do
  use FunPark.DataCase

  alias FunPark.List, as: FPList
  alias FunPark.Patron

  @moduletag :capture_log

  doctest FPList

  test "Chapter 2. Implement Domain-Specific Equality with Protocols" do
    patron_a = build(:patron)
    change_a = Patron.change(patron_a, %{ticket_tier: :premium})
    assert change_a.ticket_tier == :premium

    # change_a is filtered out
    assert [^patron_a] = FPList.uniq([patron_a, change_a])
  end
end
