defmodule TruckExpenseSystem.Repo do
  use Ecto.Repo,
    otp_app: :truck_expense_system,
    adapter: Ecto.Adapters.Postgres
end
