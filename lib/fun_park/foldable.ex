defprotocol FunPark.Foldable do
  @moduledoc false
  def fold_l(structure, transform_fn, base)
  def fold_r(structure, transform_fun, base)
end

defimpl FunPark.Foldable, for: List do
  def fold_l(list, acc, func), do: :lists.foldl(func, acc, list)
  def fold_r(list, acc, func), do: :lists.foldr(func, acc, list)
end

defimpl FunPark.Foldable, for: Function do
  def fold_l(predicate, true_func, false_func) do
    case predicate.() do
      true -> true_func.()
      false -> false_func.()
    end
  end

  def fold_r(predicate, true_func, false_func) do
    fold_l(predicate, true_func, false_func)
  end
end
