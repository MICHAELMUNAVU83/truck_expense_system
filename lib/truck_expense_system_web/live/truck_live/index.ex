defmodule TruckExpenseSystemWeb.TruckLive.Index do
  use TruckExpenseSystemWeb, :live_view

  alias TruckExpenseSystem.Trucks
  alias TruckExpenseSystem.Trucks.Truck
  alias TruckExpenseSystem.Users

  @impl true
  def mount(_params, session, socket) do
    current_user = Users.get_user_by_session_token(session["user_token"])
    search_changeset = Trucks.change_truck(%Truck{})

    {:ok,
     socket
     |> assign(:trucks, list_trucks())
     |> assign(:current_user, current_user)
     |> assign(:search_changeset, search_changeset)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Truck")
    |> assign(:truck, Trucks.get_truck!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Truck")
    |> assign(:truck, %Truck{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Trucks")
    |> assign(:truck, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    truck = Trucks.get_truck!(id)
    {:ok, _} = Trucks.delete_truck(truck)

    {:noreply, assign(socket, :trucks, list_trucks())}
  end

  def handle_event("search", %{"truck" => truck_params}, socket) do
    {:noreply,
     socket
     |> assign(
       :trucks,
       Trucks.get_truck_search_results(truck_params["search"])
     )
     |> assign(
       :search_changeset,
       Trucks.change_truck(%Truck{}, truck_params)
     )}
  end

  defp list_trucks do
    Trucks.list_trucks()
  end
end
