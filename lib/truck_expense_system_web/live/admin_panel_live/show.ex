defmodule TruckExpenseSystemWeb.AdminPanelLive.Show do
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
    truck = Trucks.get_truck!(params["id"])

    pending_spares =
      truck.spares
      |> Enum.filter(fn spare -> spare.approved == false end)

    approved_spares =
      truck.spares
      |> Enum.filter(fn spare -> spare.approved == true end)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:approved_spares, approved_spares)
     |> assign(:pending_spares, pending_spares)
     |> assign(:truck, Trucks.get_truck!(params["id"]))}
  end

  def handle_event("approve_spare", %{"id" => id}, socket) do
    spare = Spares.get_spare!(id)
    {:ok, _} = Spares.update_spare(spare, %{approved: true})

    truck = Trucks.get_truck!(spare.truck_id)

    pending_spares =
      truck.spares
      |> Enum.filter(fn spare -> spare.approved == false end)

    approved_spares =
      truck.spares
      |> Enum.filter(fn spare -> spare.approved == true end)

    {:noreply,
     socket
     |> put_flash(:info, "Spare approved")
     |> assign(:approved_spares, approved_spares)
     |> assign(:pending_spares, pending_spares)}
  end

  def handle_event("disapprove_spare", %{"id" => id}, socket) do
    spare = Spares.get_spare!(id)
    {:ok, _} = Spares.update_spare(spare, %{approved: false})

    truck = Trucks.get_truck!(spare.truck_id)

    pending_spares =
      truck.spares
      |> Enum.filter(fn spare -> spare.approved == false end)

    approved_spares =
      truck.spares
      |> Enum.filter(fn spare -> spare.approved == true end)

    {:noreply,
     socket
     |> put_flash(:info, "Spare approved")
     |> assign(:approved_spares, approved_spares)
     |> assign(:pending_spares, pending_spares)}
  end

  defp page_title(:show), do: "Show Truck"
end
