defmodule TruckExpenseSystemWeb.AdminPanelLive.Index do
  use TruckExpenseSystemWeb, :live_view
  alias TruckExpenseSystem.Spares
  alias TruckExpenseSystem.Trucks

  def mount(_params, _session, socket) do
    trucks = Trucks.list_trucks()

    {:ok,
     socket
     |> assign(:trucks, trucks)}
  end

  def handle_event("approve_spare", %{"id" => id}, socket) do
    spare = Spares.get_spare!(id)
    {:ok, _} = Spares.update_spare(spare, %{approved: true})

    pending_spares =
      Spares.list_spares()
      |> Enum.filter(fn spare -> spare.approved == false end)

    approved_spares =
      Spares.list_spares()
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

    pending_spares =
      Spares.list_spares()
      |> Enum.filter(fn spare -> spare.approved == false end)

    approved_spares =
      Spares.list_spares()
      |> Enum.filter(fn spare -> spare.approved == true end)

    {:noreply,
     socket
     |> put_flash(:info, "Spare approved")
     |> assign(:approved_spares, approved_spares)
     |> assign(:pending_spares, pending_spares)}
  end
end
