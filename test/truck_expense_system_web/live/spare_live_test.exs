defmodule TruckExpenseSystemWeb.SpareLiveTest do
  use TruckExpenseSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import TruckExpenseSystem.SparesFixtures

  @create_attrs %{name: "some name", type_of_spare: "some type_of_spare", cost: 42, quantity: "some quantity", total_cost: 42, location_purchased_at: "some location_purchased_at"}
  @update_attrs %{name: "some updated name", type_of_spare: "some updated type_of_spare", cost: 43, quantity: "some updated quantity", total_cost: 43, location_purchased_at: "some updated location_purchased_at"}
  @invalid_attrs %{name: nil, type_of_spare: nil, cost: nil, quantity: nil, total_cost: nil, location_purchased_at: nil}

  defp create_spare(_) do
    spare = spare_fixture()
    %{spare: spare}
  end

  describe "Index" do
    setup [:create_spare]

    test "lists all spares", %{conn: conn, spare: spare} do
      {:ok, _index_live, html} = live(conn, Routes.spare_index_path(conn, :index))

      assert html =~ "Listing Spares"
      assert html =~ spare.name
    end

    test "saves new spare", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.spare_index_path(conn, :index))

      assert index_live |> element("a", "New Spare") |> render_click() =~
               "New Spare"

      assert_patch(index_live, Routes.spare_index_path(conn, :new))

      assert index_live
             |> form("#spare-form", spare: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#spare-form", spare: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.spare_index_path(conn, :index))

      assert html =~ "Spare created successfully"
      assert html =~ "some name"
    end

    test "updates spare in listing", %{conn: conn, spare: spare} do
      {:ok, index_live, _html} = live(conn, Routes.spare_index_path(conn, :index))

      assert index_live |> element("#spare-#{spare.id} a", "Edit") |> render_click() =~
               "Edit Spare"

      assert_patch(index_live, Routes.spare_index_path(conn, :edit, spare))

      assert index_live
             |> form("#spare-form", spare: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#spare-form", spare: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.spare_index_path(conn, :index))

      assert html =~ "Spare updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes spare in listing", %{conn: conn, spare: spare} do
      {:ok, index_live, _html} = live(conn, Routes.spare_index_path(conn, :index))

      assert index_live |> element("#spare-#{spare.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#spare-#{spare.id}")
    end
  end

  describe "Show" do
    setup [:create_spare]

    test "displays spare", %{conn: conn, spare: spare} do
      {:ok, _show_live, html} = live(conn, Routes.spare_show_path(conn, :show, spare))

      assert html =~ "Show Spare"
      assert html =~ spare.name
    end

    test "updates spare within modal", %{conn: conn, spare: spare} do
      {:ok, show_live, _html} = live(conn, Routes.spare_show_path(conn, :show, spare))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Spare"

      assert_patch(show_live, Routes.spare_show_path(conn, :edit, spare))

      assert show_live
             |> form("#spare-form", spare: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#spare-form", spare: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.spare_show_path(conn, :show, spare))

      assert html =~ "Spare updated successfully"
      assert html =~ "some updated name"
    end
  end
end
