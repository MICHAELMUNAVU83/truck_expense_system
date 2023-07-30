defmodule TruckExpenseSystemWeb.TruckLive.FormComponent do
  use TruckExpenseSystemWeb, :live_component

  alias TruckExpenseSystem.Trucks

  @impl true
  def update(%{truck: truck} = assigns, socket) do
    changeset = Trucks.change_truck(truck)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 1)}
  end

  @impl true
  def handle_event("validate", %{"truck" => truck_params}, socket) do
    changeset =
      socket.assigns.truck
      |> Trucks.change_truck(truck_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"truck" => truck_params}, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest =
          Path.join([
            :code.priv_dir(:truck_expense_system),
            "static",
            "uploads",
            Path.basename(path)
          ])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

    new_truck_params = Map.put(truck_params, "image", List.first(uploaded_files))

    save_truck(socket, socket.assigns.action, new_truck_params)
  end

  defp save_truck(socket, :edit, truck_params) do
    case Trucks.update_truck(socket.assigns.truck, truck_params) do
      {:ok, _truck} ->
        {:noreply,
         socket
         |> put_flash(:info, "Truck updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_truck(socket, :new, truck_params) do
    case Trucks.create_truck(truck_params) do
      {:ok, _truck} ->
        {:noreply,
         socket
         |> put_flash(:info, "Truck created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
