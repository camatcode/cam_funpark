defmodule FunPark.List do
  @moduledoc false

  alias FunPark.Eq.Utils

  def uniq(list, eq \\ FunPark.Eq) when is_list(list) do
    list
    |> Enum.reduce([], fn item, acc ->
      if Enum.any?(acc, &Utils.eq?(item, &1, eq)),
        do: acc,
        else: [item | acc]
    end)
    |> Enum.reverse()
  end
end
