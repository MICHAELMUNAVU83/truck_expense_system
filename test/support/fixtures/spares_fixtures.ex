defmodule TruckExpenseSystem.SparesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TruckExpenseSystem.Spares` context.
  """

  @doc """
  Generate a spare.
  """
  def spare_fixture(attrs \\ %{}) do
    {:ok, spare} =
      attrs
      |> Enum.into(%{
        name: "some name",
        type_of_spare: "some type_of_spare",
        cost: 42,
        quantity: "some quantity",
        total_cost: 42,
        location_purchased_at: "some location_purchased_at"
      })
      |> TruckExpenseSystem.Spares.create_spare()

    spare
  end
end
