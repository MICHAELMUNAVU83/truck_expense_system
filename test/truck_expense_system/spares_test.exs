defmodule TruckExpenseSystem.SparesTest do
  use TruckExpenseSystem.DataCase

  alias TruckExpenseSystem.Spares

  describe "spares" do
    alias TruckExpenseSystem.Spares.Spare

    import TruckExpenseSystem.SparesFixtures

    @invalid_attrs %{
      name: nil,
      type_of_spare: nil,
      cost: nil,
      quantity: nil,
      total_cost: nil,
      location_purchased_at: nil
    }

    test "list_spares/0 returns all spares" do
      spare = spare_fixture()
      assert Spares.list_spares() == [spare]
    end

    test "get_spare!/1 returns the spare with given id" do
      spare = spare_fixture()
      assert Spares.get_spare!(spare.id) == spare
    end

    test "create_spare/1 with valid data creates a spare" do
      valid_attrs = %{
        name: "some name",
        type_of_spare: "some type_of_spare",
        cost: 42,
        quantity: "some quantity",
        total_cost: 42,
        location_purchased_at: "some location_purchased_at"
      }

      assert {:ok, %Spare{} = spare} = Spares.create_spare(valid_attrs)
      assert spare.name == "some name"
      assert spare.type_of_spare == "some type_of_spare"
      assert spare.cost == 42
      assert spare.quantity == "some quantity"
      assert spare.total_cost == 42
      assert spare.location_purchased_at == "some location_purchased_at"
    end

    test "create_spare/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spares.create_spare(@invalid_attrs)
    end

    test "update_spare/2 with valid data updates the spare" do
      spare = spare_fixture()

      update_attrs = %{
        name: "some updated name",
        type_of_spare: "some updated type_of_spare",
        cost: 43,
        quantity: "some updated quantity",
        total_cost: 43,
        location_purchased_at: "some updated location_purchased_at"
      }

      assert {:ok, %Spare{} = spare} = Spares.update_spare(spare, update_attrs)
      assert spare.name == "some updated name"
      assert spare.type_of_spare == "some updated type_of_spare"
      assert spare.cost == 43
      assert spare.quantity == "some updated quantity"
      assert spare.total_cost == 43
      assert spare.location_purchased_at == "some updated location_purchased_at"
    end

    test "update_spare/2 with invalid data returns error changeset" do
      spare = spare_fixture()
      assert {:error, %Ecto.Changeset{}} = Spares.update_spare(spare, @invalid_attrs)
      assert spare == Spares.get_spare!(spare.id)
    end

    test "delete_spare/1 deletes the spare" do
      spare = spare_fixture()
      assert {:ok, %Spare{}} = Spares.delete_spare(spare)
      assert_raise Ecto.NoResultsError, fn -> Spares.get_spare!(spare.id) end
    end

    test "change_spare/1 returns a spare changeset" do
      spare = spare_fixture()
      assert %Ecto.Changeset{} = Spares.change_spare(spare)
    end
  end
end
