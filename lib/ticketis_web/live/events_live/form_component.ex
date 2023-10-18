defmodule TicketisWeb.EventsLive.FormComponent do
  use TicketisWeb, :live_component

  alias Ticketis.Event

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage events records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="events-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:image]} type="text" label="Image" />
        <.input field={@form[:start_date]} type="datetime-local" label="Start date" />
        <.input field={@form[:end_date]} type="datetime-local" label="End date" />
        <.input field={@form[:is_visible]} type="checkbox" label="Is visible" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Events</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{events: events} = assigns, socket) do
    changeset = Event.change_events(events)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"events" => events_params}, socket) do
    changeset =
      socket.assigns.events
      |> Event.change_events(events_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"events" => events_params}, socket) do
    save_events(socket, socket.assigns.action, events_params)
  end

  defp save_events(socket, :edit, events_params) do
    case Event.update_events(socket.assigns.events, events_params) do
      {:ok, events} ->
        notify_parent({:saved, events})

        {:noreply,
         socket
         |> put_flash(:info, "Events updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_events(socket, :new, events_params) do
    case Event.create_events(events_params) do
      {:ok, events} ->
        notify_parent({:saved, events})

        {:noreply,
         socket
         |> put_flash(:info, "Events created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
