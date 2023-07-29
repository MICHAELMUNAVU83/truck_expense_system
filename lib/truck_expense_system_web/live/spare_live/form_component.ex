defmodule TruckExpenseSystemWeb.SpareLive.FormComponent do
  use TruckExpenseSystemWeb, :live_component

  alias TruckExpenseSystem.Spares

  @impl true
  def update(%{spare: spare} = assigns, socket) do
    changeset = Spares.change_spare(spare)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"spare" => spare_params}, socket) do
    changeset =
      socket.assigns.spare
      |> Spares.change_spare(spare_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"spare" => spare_params}, socket) do
    save_spare(socket, socket.assigns.action, spare_params)
  end

  defp save_spare(socket, :edit, spare_params) do
    case Spares.update_spare(socket.assigns.spare, spare_params) do
      {:ok, _spare} ->
        {:noreply,
         socket
         |> put_flash(:info, "Spare updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_spare(socket, :new, spare_params) do
    case Spares.create_spare(spare_params) do
      {:ok, _spare} ->
        {:noreply,
         socket
         |> put_flash(:info, "Spare created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
