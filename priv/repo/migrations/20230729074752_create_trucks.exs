defmodule TruckExpenseSystem.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add(:registration_number, :string)
      add(:image, :string)
      add(:description, :string)
      add(:user_id, references(:users, on_delete: :nothing))

      timestamps()
    end
  end
end
