defmodule FunPark.Patron do
  @moduledoc false
  alias __MODULE__, as: Patron

  defstruct [:id, :name, age: 0, height: 0, ticket_tier: :basic, fast_passes: [], reward_points: 0, likes: [], dislikes: []]

  def make(name, age, height, opts \\ [])
      when is_bitstring(name) and is_integer(age) and is_integer(height) and age > 0 and height > 0 do
    %Patron{
      id: :erlang.unique_integer([:positive, :monotonic]),
      name: name,
      age: age,
      height: height,
      ticket_tier: Keyword.get(opts, :ticket_tier, :basic),
      fast_passes: Keyword.get(opts, :fast_passes, []),
      reward_points: Keyword.get(opts, :reward_points, 0),
      likes: Keyword.get(opts, :likes, []),
      dislikes: Keyword.get(opts, :dislikes, [])
    }
  end

  def change(%Patron{} = patron, %{} = attrs) do
    Map.delete(attrs, :id)
    |> then(&struct(patron, &1))
  end
end
