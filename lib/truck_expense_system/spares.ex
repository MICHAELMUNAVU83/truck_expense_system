defmodule TruckExpenseSystem.Spares do
  @moduledoc """
  The Spares context.
  """

  import Ecto.Query, warn: false
  alias TruckExpenseSystem.Repo

  alias TruckExpenseSystem.Spares.Spare

  @doc """
  Returns the list of spares.

  ## Examples

      iex> list_spares()
      [%Spare{}, ...]

  """
  def list_spares do
    Repo.all(Spare)
  end

  @doc """
  Gets a single spare.

  Raises `Ecto.NoResultsError` if the Spare does not exist.

  ## Examples

      iex> get_spare!(123)
      %Spare{}

      iex> get_spare!(456)
      ** (Ecto.NoResultsError)

  """
  def get_spare!(id), do: Repo.get!(Spare, id)

  @doc """
  Creates a spare.

  ## Examples

      iex> create_spare(%{field: value})
      {:ok, %Spare{}}

      iex> create_spare(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_spare(attrs \\ %{}) do
    %Spare{}
    |> Spare.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a spare.

  ## Examples

      iex> update_spare(spare, %{field: new_value})
      {:ok, %Spare{}}

      iex> update_spare(spare, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_spare(%Spare{} = spare, attrs) do
    spare
    |> Spare.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a spare.

  ## Examples

      iex> delete_spare(spare)
      {:ok, %Spare{}}

      iex> delete_spare(spare)
      {:error, %Ecto.Changeset{}}

  """
  def delete_spare(%Spare{} = spare) do
    Repo.delete(spare)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking spare changes.

  ## Examples

      iex> change_spare(spare)
      %Ecto.Changeset{data: %Spare{}}

  """
  def change_spare(%Spare{} = spare, attrs \\ %{}) do
    Spare.changeset(spare, attrs)
  end
end
