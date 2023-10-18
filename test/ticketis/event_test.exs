defmodule Ticketis.EventTest do
  use Ticketis.DataCase

  alias Ticketis.Event

  describe "events" do
    alias Ticketis.Event.Events

    import Ticketis.EventFixtures

    @invalid_attrs %{description: nil, end_date: nil, image: nil, is_active: nil, is_visible: nil, name: nil, start_date: nil}

    test "list_events/0 returns all events" do
      events = events_fixture()
      assert Event.list_events() == [events]
    end

    test "get_events!/1 returns the events with given id" do
      events = events_fixture()
      assert Event.get_events!(events.id) == events
    end

    test "create_events/1 with valid data creates a events" do
      valid_attrs = %{description: "some description", end_date: ~N[2023-10-16 03:28:00], image: "some image", is_active: true, is_visible: true, name: "some name", start_date: ~N[2023-10-16 03:28:00]}

      assert {:ok, %Events{} = events} = Event.create_events(valid_attrs)
      assert events.description == "some description"
      assert events.end_date == ~N[2023-10-16 03:28:00]
      assert events.image == "some image"
      assert events.is_active == true
      assert events.is_visible == true
      assert events.name == "some name"
      assert events.start_date == ~N[2023-10-16 03:28:00]
    end

    test "create_events/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Event.create_events(@invalid_attrs)
    end

    test "update_events/2 with valid data updates the events" do
      events = events_fixture()
      update_attrs = %{description: "some updated description", end_date: ~N[2023-10-17 03:28:00], image: "some updated image", is_active: false, is_visible: false, name: "some updated name", start_date: ~N[2023-10-17 03:28:00]}

      assert {:ok, %Events{} = events} = Event.update_events(events, update_attrs)
      assert events.description == "some updated description"
      assert events.end_date == ~N[2023-10-17 03:28:00]
      assert events.image == "some updated image"
      assert events.is_active == false
      assert events.is_visible == false
      assert events.name == "some updated name"
      assert events.start_date == ~N[2023-10-17 03:28:00]
    end

    test "update_events/2 with invalid data returns error changeset" do
      events = events_fixture()
      assert {:error, %Ecto.Changeset{}} = Event.update_events(events, @invalid_attrs)
      assert events == Event.get_events!(events.id)
    end

    test "delete_events/1 deletes the events" do
      events = events_fixture()
      assert {:ok, %Events{}} = Event.delete_events(events)
      assert_raise Ecto.NoResultsError, fn -> Event.get_events!(events.id) end
    end

    test "change_events/1 returns a events changeset" do
      events = events_fixture()
      assert %Ecto.Changeset{} = Event.change_events(events)
    end
  end
end
