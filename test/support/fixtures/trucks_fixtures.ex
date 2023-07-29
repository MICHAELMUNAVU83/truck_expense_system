defmodule TruckExpenseSystem.TrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TruckExpenseSystem.Trucks` context.
  """

  @doc """
  Generate a truck.
  """
  def truck_fixture(attrs \\ %{}) do
    {:ok, truck} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: "some image",
        registration_number: "some registration_number"
      })
      |> TruckExpenseSystem.Trucks.create_truck()

    truck
  end
end
