defmodule TruckExpenseSystemWeb.TruckLiveTest do
  use TruckExpenseSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import TruckExpenseSystem.TrucksFixtures

  @create_attrs %{description: "some description", image: "some image", registration_number: "some registration_number"}
  @update_attrs %{description: "some updated description", image: "some updated image", registration_number: "some updated registration_number"}
  @invalid_attrs %{description: nil, image: nil, registration_number: nil}

  defp create_truck(_) do
    truck = truck_fixture()
    %{truck: truck}
  end

  describe "Index" do
    setup [:create_truck]

    test "lists all trucks", %{conn: conn, truck: truck} do
      {:ok, _index_live, html} = live(conn, Routes.truck_index_path(conn, :index))

      assert html =~ "Listing Trucks"
      assert html =~ truck.description
    end

    test "saves new truck", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.truck_index_path(conn, :index))

      assert index_live |> element("a", "New Truck") |> render_click() =~
               "New Truck"

      assert_patch(index_live, Routes.truck_index_path(conn, :new))

      assert index_live
             |> form("#truck-form", truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#truck-form", truck: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.truck_index_path(conn, :index))

      assert html =~ "Truck created successfully"
      assert html =~ "some description"
    end

    test "updates truck in listing", %{conn: conn, truck: truck} do
      {:ok, index_live, _html} = live(conn, Routes.truck_index_path(conn, :index))

      assert index_live |> element("#truck-#{truck.id} a", "Edit") |> render_click() =~
               "Edit Truck"

      assert_patch(index_live, Routes.truck_index_path(conn, :edit, truck))

      assert index_live
             |> form("#truck-form", truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#truck-form", truck: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.truck_index_path(conn, :index))

      assert html =~ "Truck updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes truck in listing", %{conn: conn, truck: truck} do
      {:ok, index_live, _html} = live(conn, Routes.truck_index_path(conn, :index))

      assert index_live |> element("#truck-#{truck.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#truck-#{truck.id}")
    end
  end

  describe "Show" do
    setup [:create_truck]

    test "displays truck", %{conn: conn, truck: truck} do
      {:ok, _show_live, html} = live(conn, Routes.truck_show_path(conn, :show, truck))

      assert html =~ "Show Truck"
      assert html =~ truck.description
    end

    test "updates truck within modal", %{conn: conn, truck: truck} do
      {:ok, show_live, _html} = live(conn, Routes.truck_show_path(conn, :show, truck))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Truck"

      assert_patch(show_live, Routes.truck_show_path(conn, :edit, truck))

      assert show_live
             |> form("#truck-form", truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#truck-form", truck: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.truck_show_path(conn, :show, truck))

      assert html =~ "Truck updated successfully"
      assert html =~ "some updated description"
    end
  end
end
