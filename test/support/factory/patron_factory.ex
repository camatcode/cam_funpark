defmodule FunPark.Factory.PatronFactory do
  @moduledoc false
  use ExMachina

  defmacro __using__(_opts) do
    quote do
      alias FunPark.Patron

      def patron_factory do
        ticket_tiers = [:basic, :preimum, :vip]

        %{
          name: Faker.Person.name(),
          age: Enum.random(1..100),
          height: Enum.random(0..200),
          ticket_tier: Enum.random(ticket_tiers),
          fast_passes:
            0..Enum.random(0..5)
            |> Enum.map(fn _ -> build(:fast_pass) end),
          reward_points: Enum.random(0..200),
          likes: [],
          dislikes: []
        }
        |> Patron.make()
      end
    end
  end
end
