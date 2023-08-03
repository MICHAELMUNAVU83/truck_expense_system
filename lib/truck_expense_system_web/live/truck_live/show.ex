defmodule TruckExpenseSystemWeb.TruckLive.Show do
  use TruckExpenseSystemWeb, :live_view

  alias TruckExpenseSystem.Trucks
  alias TruckExpenseSystem.Trucks.Truck
  alias TruckExpenseSystem.Spares
  alias TruckExpenseSystem.Spares.Spare
  alias TruckExpenseSystem.Users

  @impl true
  def mount(_params, session, socket) do
    current_user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:current_user, current_user)}
  end

  @impl true
  def handle_params(params, _, socket) do
    IO.inspect(params)

    spare =
      if params["spare_id"] do
        Spares.get_spare!(params["spare_id"])
      else
        %Spare{}
      end

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:spare, spare)
     |> assign(:truck, Trucks.get_truck!(params["id"]))}
  end

  def handle_event("delete_spare", %{"id" => id}, socket) do
    spare = Spares.get_spare!(id)
    {:ok, _} = Spares.delete_spare(spare)
    truck = Trucks.get_truck!(spare.truck_id)

    {:noreply,
     socket
     |> assign(:truck, truck)}
  end

  defp page_title(:show), do: "Show Truck"
  defp page_title(:edit), do: "Edit Truck"
  defp page_title(:add_spare), do: "Add Spare"
  defp page_title(:edit_spare), do: "Edit Spare"
end
