defmodule FunPark.Factory.FastPassFactory do
  @moduledoc false
  use ExMachina

  defmacro __using__(_opts) do
    quote do
      alias FunPark.FastPass

      def fast_pass_factory do
        ticket_tiers = [:basic, :preimum]

        %{
          ride: build(:ride),
          time: Faker.DateTime.forward(5)
        }
        |> FastPass.make()
      end
    end
  end
end
