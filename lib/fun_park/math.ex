defmodule FunPark.Math do
  @moduledoc false

  alias FunPark.Monoid.Sum
  alias FunPark.Monoid.Utils

  def sum(a, b) do
    Utils.m_append(%Sum{}, a, b)
  end

  def sum(list) when is_list(list) do
    Utils.m_concat(%Sum{}, list)
  end
end
