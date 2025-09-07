defmodule FunPark.Math do
  @moduledoc false

  alias FunPark.Monoid.Max
  alias FunPark.Monoid.Sum
  alias FunPark.Monoid.Utils

  def sum(a, b) do
    Utils.m_append(%Sum{}, a, b)
  end

  def sum(list) when is_list(list) do
    Utils.m_concat(%Sum{}, list)
  end

  def max(a, b), do: Utils.m_append(%Max{value: Float.min_finite()}, a, b)
  def max(list) when is_list(list), do: Utils.m_concat(%Max{value: Float.min_finite()}, list)
end
