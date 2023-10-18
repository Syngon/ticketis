defmodule TicketisWeb.EventsLive.Index do
  use TicketisWeb, :live_view

  alias Ticketis.Event
  alias Ticketis.Event.Schemas.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :events_collection, Event.list_events())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Events")
    |> assign(:events, Event.get_events!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Events")
    |> assign(:events, %Events{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Events")
    |> assign(:events, nil)
  end

  @impl true
  def handle_info({TicketisWeb.EventsLive.FormComponent, {:saved, events}}, socket) do
    {:noreply, stream_insert(socket, :events_collection, events)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    events = Event.get_events!(id)
    {:ok, _} = Event.delete_events(events)

    {:noreply, stream_delete(socket, :events_collection, events)}
  end
end
