defmodule FunPark.Predicate do
  @moduledoc false
  import FunPark.Monoid.Utils, only: [m_append: 3, m_concat: 2]

  alias FunPark.Monoid.Predicate.All
  alias FunPark.Monoid.Predicate.Any

  def p_and(pred1, pred2) when is_function(pred1) and is_function(pred2), do: m_append(%All{}, pred1, pred2)

  def p_or(pred1, pred2) when is_function(pred1) and is_function(pred2), do: m_append(%Any{}, pred1, pred2)

  def p_not(pred) when is_function(pred), do: fn value -> not pred.(value) end

  def p_all(p_list) when is_list(p_list), do: m_concat(%All{}, p_list)

  def p_any(p_list) when is_list(p_list), do: m_concat(%Any{}, p_list)

  def p_none(p_list) when is_list(p_list), do: p_not(p_any(p_list))
end
