defmodule TruckExpenseSystem.Trucks do
  @moduledoc """
  The Trucks context.
  """

  import Ecto.Query, warn: false
  alias TruckExpenseSystem.Repo

  alias TruckExpenseSystem.Trucks.Truck
  alias TruckExpenseSystem.Spares.Spare

  @doc """
  Returns the list of trucks.

  ## Examples

      iex> list_trucks()
      [%Truck{}, ...]

  """
  def list_trucks do
    Repo.all(Truck)
    |> Repo.preload(:spares)
  end

  def calculate_total_spares(spares) do
    total = 0

    for spare <- spares do
      total = total + spare.total_cost
    end

    total
  end

  def get_truck_search_results(searchterm) do
    Repo.all(Truck)
    |> Enum.filter(fn truck ->
      String.contains?(String.downcase(truck.registration_number), String.downcase(searchterm)) or
        String.contains?(String.downcase(truck.description), String.downcase(searchterm))
    end)
  end

  def get_pending_spare_approvals_for_a_truck(id) do
    Repo.all(Spare)
    |> Enum.filter(fn spare -> spare.truck_id == id and spare.approved == false end)
  end

  def get_approved_spare_approvals_for_a_truck(id) do
    Repo.all(Spare)
    |> Enum.filter(fn spare -> spare.truck_id == id and spare.approved == true end)
  end

  def get_total_spent_for_a_truck(id) do
    Repo.all(Spare)
    |> Enum.filter(fn spare -> spare.truck_id == id and spare.approved == false end)
    |> Enum.map(fn spare -> spare.total_cost end)
    |> Enum.sum()
  end

  @doc """
  Gets a single truck.

  Raises `Ecto.NoResultsError` if the Truck does not exist.

  ## Examples

      iex> get_truck!(123)
      %Truck{}

      iex> get_truck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_truck!(id), do: Repo.get!(Truck, id) |> Repo.preload(:spares)

  @doc """
  Creates a truck.

  ## Examples

      iex> create_truck(%{field: value})
      {:ok, %Truck{}}

      iex> create_truck(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_truck(attrs \\ %{}) do
    %Truck{}
    |> Truck.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a truck.

  ## Examples

      iex> update_truck(truck, %{field: new_value})
      {:ok, %Truck{}}

      iex> update_truck(truck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_truck(%Truck{} = truck, attrs) do
    truck
    |> Truck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a truck.

  ## Examples

      iex> delete_truck(truck)
      {:ok, %Truck{}}

      iex> delete_truck(truck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_truck(%Truck{} = truck) do
    Repo.delete(truck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking truck changes.

  ## Examples

      iex> change_truck(truck)
      %Ecto.Changeset{data: %Truck{}}

  """
  def change_truck(%Truck{} = truck, attrs \\ %{}) do
    Truck.changeset(truck, attrs)
  end
end
