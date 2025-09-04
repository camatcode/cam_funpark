defmodule FunPark.List do
  @moduledoc false

  alias FunPark.Eq
  alias FunPark.Ord

  def uniq(list, eq \\ FunPark.Eq) when is_list(list) do
    list
    |> Enum.reduce([], fn item, acc ->
      if Enum.any?(acc, &Eq.Utils.eq?(item, &1, eq)),
        do: acc,
        else: [item | acc]
    end)
    |> Enum.reverse()
  end

  def union(list1, list2, eq \\ FunPark.Eq) when is_list(list1) and is_list(list2) do
    (list1 ++ list2) |> uniq(eq)
  end

  def intersection(list1, list2, eq \\ FunPark.Eq) when is_list(list1) and is_list(list2) do
    list1
    |> Enum.filter(fn item ->
      Enum.any?(list2, &Eq.Utils.eq?(item, &1, eq))
    end)
    |> uniq()
  end

  def difference(list1, list2, eq \\ FunPark.Eq) when is_list(list1) and is_list(list2) do
    list1
    |> Enum.reject(fn item ->
      Enum.any?(list2, &Eq.Utils.eq?(item, &1, eq))
    end)
    |> uniq()
  end

  def symmetric_difference(list1, list2, eq \\ FunPark.Eq) when is_list(list1) and is_list(list2) do
    (difference(list1, list2, eq) ++ difference(list2, list1, eq))
    |> uniq()
  end

  def subset?(small, large, eq \\ FunPark.Eq) when is_list(small) and is_list(large) do
    Enum.all?(small, fn item -> Enum.any?(large, &Eq.Utils.eq?(item, &1, eq)) end)
  end

  def superset?(large, small, eq \\ FunPark.Eq) when is_list(small) and is_list(large) do
    subset?(small, large, eq)
  end

  def sort(list, ord \\ FunPark.Ord) when is_list(list), do: Enum.sort(list, Ord.Utils.comparator(ord))

  def strict_sort(list, ord \\ FunPark.Ord) when is_list(list) do
    list
    |> uniq(Ord.Utils.to_eq(ord))
    |> sort(ord)
  end
end
