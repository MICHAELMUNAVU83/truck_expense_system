defmodule TruckExpenseSystem.Trucks.Truck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trucks" do
    field :description, :string
    field :image, :string
    field :registration_number, :string

    timestamps()
  end

  @doc false
  def changeset(truck, attrs) do
    truck
    |> cast(attrs, [:registration_number, :image, :description])
    |> validate_required([:registration_number, :image, :description])
  end
end
