defmodule FunPark.Patron do
  @moduledoc false
  import FunPark.Macros, only: [ord_for: 2]
  import FunPark.Monoid.Utils, only: [m_concat: 2]

  alias __MODULE__, as: Patron
  alias FunPark.Monoid.Max
  alias FunPark.Ord

  defstruct [:id, :name, age: 0, height: 0, ticket_tier: :basic, fast_passes: [], reward_points: 0, likes: [], dislikes: []]

  ord_for(Patron, :name)

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

  def get_height(%Patron{height: height}), do: height
  def get_age(%Patron{age: age}), do: age

  def highest_priority(patrons) when is_list(patrons), do: m_concat(max_priority_monoid(), patrons)

  def ord_by_ticket_tier, do: Ord.Utils.contramap(&get_ticket_tier_priority/1)
  def ord_by_reward_points, do: Ord.Utils.contramap(&get_reward_points/1)
  def ord_by_priority, do: Ord.Utils.concat([ord_by_ticket_tier(), ord_by_reward_points(), Ord])

  defp priority_empty, do: %Patron{reward_points: Float.min_finite(), ticket_tier: nil}
  defp max_priority_monoid, do: %Max{value: priority_empty(), ord: ord_by_priority()}

  defp tier_priority(:vip), do: 3
  defp tier_priority(:premium), do: 2
  defp tier_priority(:basic), do: 1
  defp tier_priority(_), do: 0

  defp get_ticket_tier_priority(%Patron{ticket_tier: tier}), do: tier_priority(tier)
  defp get_reward_points(%Patron{reward_points: points}), do: points
end
