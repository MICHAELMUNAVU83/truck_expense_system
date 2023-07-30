defmodule TruckExpenseSystemWeb.AdminPanelLive.Index do
  use TruckExpenseSystemWeb, :live_view
  alias TruckExpenseSystem.Spares

  def mount(_params, _session, socket) do
    pending_spares =
      Spares.list_spares()
      |> Enum.filter(fn spare -> spare.approved == false end)

    {:ok,
     socket
     |> assign(:pending_spares, pending_spares)}
  end
end
