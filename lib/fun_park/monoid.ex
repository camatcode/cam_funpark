defprotocol FunPark.Monoid do
  @moduledoc false

  # returns the identity element, leaves the value unchanged
  def identity(monoid_struct)
  # combines two values in an associative way
  def append(monoid_struct_a, monoid_struct_b)
  # puts the value in the struct
  def wrap(monoid_struct, value)
  # gets the value out of the struct
  def unwrap(monoid_struct)
end
