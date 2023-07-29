defmodule TruckExpenseSystemWeb.SpareLive.Index do
  use TruckExpenseSystemWeb, :live_view

  alias TruckExpenseSystem.Spares
  alias TruckExpenseSystem.Spares.Spare

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :spares, list_spares())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Spare")
    |> assign(:spare, Spares.get_spare!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Spare")
    |> assign(:spare, %Spare{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Spares")
    |> assign(:spare, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    spare = Spares.get_spare!(id)
    {:ok, _} = Spares.delete_spare(spare)

    {:noreply, assign(socket, :spares, list_spares())}
  end

  defp list_spares do
    Spares.list_spares()
  end
end
