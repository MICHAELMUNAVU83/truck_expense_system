defmodule TruckExpenseSystem.Spares.Spare do
  use Ecto.Schema
  import Ecto.Changeset

  schema "spares" do
    field(:name, :string)
    field(:type_of_spare, :string)
    field(:cost, :integer)
    field(:quantity, :integer)
    field(:total_cost, :integer)
    field(:location_purchased_at, :string)
    field(:approved, :boolean, default: false)
    belongs_to(:truck, TruckExpenseSystem.Trucks.Truck)
    belongs_to(:user, TruckExpenseSystem.Users.User)

    timestamps()
  end

  @doc false
  def changeset(spare, attrs) do
    spare
    |> cast(attrs, [
      :name,
      :type_of_spare,
      :cost,
      :quantity,
      :total_cost,
      :location_purchased_at,
      :truck_id,
      :approved,
      :user_id
    ])
    |> validate_required([
      :name,
      :type_of_spare,
      :cost,
      :quantity,
      :total_cost,
      :location_purchased_at,
      :truck_id,
      :approved,
      :user_id
    ])
  end
end
