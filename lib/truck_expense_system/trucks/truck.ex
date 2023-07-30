defmodule TruckExpenseSystem.Trucks.Truck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trucks" do
    field(:description, :string)
    field(:image, :string)
    field(:registration_number, :string)
    belongs_to(:user, TruckExpenseSystem.Users.User)
    has_many(:spares, TruckExpenseSystem.Spares.Spare)

    timestamps()
  end

  @doc false
  def changeset(truck, attrs) do
    truck
    |> cast(attrs, [:registration_number, :image, :description, :user_id])
    |> validate_required([:registration_number, :image, :description, :user_id])
  end
end
