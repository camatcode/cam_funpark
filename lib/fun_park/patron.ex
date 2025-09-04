defmodule FunPark.Patron do
  @moduledoc false
  alias __MODULE__, as: Patron
  alias FunPark.Ord

  defstruct [:id, :name, age: 0, height: 0, ticket_tier: :basic, fast_passes: [], reward_points: 0, likes: [], dislikes: []]

  def make(%Patron{} = p), do: p

  def make(%{name: name, age: age, height: height} = m) when is_map(m) do
    opts = Enum.map(m, fn {key, value} -> {key, value} end)
    make(name, age, height, opts)
  end

  def make(name, age, height, opts \\ [])
      when is_bitstring(name) and is_integer(age) and is_integer(height) and age > 0 and height > 0 do
    %Patron{
      id: System.monotonic_time() |> abs(),
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

  def ord_by_ticket_tier, do: Ord.Utils.contramap(&get_ticket_tier_priority/1)

  defp tier_priority(:vip), do: 3
  defp tier_priority(:premium), do: 2
  defp tier_priority(:basic), do: 1
  defp tier_priority(_), do: 0
  defp get_ticket_tier_priority(%Patron{ticket_tier: tier}), do: tier_priority(tier)
end
