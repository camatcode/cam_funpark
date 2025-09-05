defprotocol FunPark.Foldable do
  @moduledoc false
  def fold_l(structure, transform_fn, base)
  def fold_r(structure, transform_fun, base)
end

defimpl FunPark.Foldable, for: List do
  def fold_l(list, acc, func), do: :lists.foldl(func, acc, list)
  def fold_r(list, acc, func), do: :lists.foldr(func, acc, list)
end
