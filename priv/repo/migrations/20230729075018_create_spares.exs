defmodule TruckExpenseSystem.Repo.Migrations.CreateSpares do
  use Ecto.Migration

  def change do
    create table(:spares) do
      add :name, :string
      add :type_of_spare, :string
      add :cost, :integer
      add :quantity, :string
      add :total_cost, :integer
      add :location_purchased_at, :string
      add :truck_id, references(:trucks, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
