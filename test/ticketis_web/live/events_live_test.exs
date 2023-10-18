defmodule TicketisWeb.EventsLiveTest do
  use TicketisWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ticketis.EventFixtures

  @create_attrs %{description: "some description", end_date: "2023-10-16T03:28:00", image: "some image", is_active: true, is_visible: true, name: "some name", start_date: "2023-10-16T03:28:00"}
  @update_attrs %{description: "some updated description", end_date: "2023-10-17T03:28:00", image: "some updated image", is_active: false, is_visible: false, name: "some updated name", start_date: "2023-10-17T03:28:00"}
  @invalid_attrs %{description: nil, end_date: nil, image: nil, is_active: false, is_visible: false, name: nil, start_date: nil}

  defp create_events(_) do
    events = events_fixture()
    %{events: events}
  end

  describe "Index" do
    setup [:create_events]

    test "lists all events", %{conn: conn, events: events} do
      {:ok, _index_live, html} = live(conn, ~p"/events")

      assert html =~ "Listing Events"
      assert html =~ events.description
    end

    test "saves new events", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/events")

      assert index_live |> element("a", "New Events") |> render_click() =~
               "New Events"

      assert_patch(index_live, ~p"/events/new")

      assert index_live
             |> form("#events-form", events: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#events-form", events: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/events")

      html = render(index_live)
      assert html =~ "Events created successfully"
      assert html =~ "some description"
    end

    test "updates events in listing", %{conn: conn, events: events} do
      {:ok, index_live, _html} = live(conn, ~p"/events")

      assert index_live |> element("#events-#{events.id} a", "Edit") |> render_click() =~
               "Edit Events"

      assert_patch(index_live, ~p"/events/#{events}/edit")

      assert index_live
             |> form("#events-form", events: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#events-form", events: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/events")

      html = render(index_live)
      assert html =~ "Events updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes events in listing", %{conn: conn, events: events} do
      {:ok, index_live, _html} = live(conn, ~p"/events")

      assert index_live |> element("#events-#{events.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#events-#{events.id}")
    end
  end

  describe "Show" do
    setup [:create_events]

    test "displays events", %{conn: conn, events: events} do
      {:ok, _show_live, html} = live(conn, ~p"/events/#{events}")

      assert html =~ "Show Events"
      assert html =~ events.description
    end

    test "updates events within modal", %{conn: conn, events: events} do
      {:ok, show_live, _html} = live(conn, ~p"/events/#{events}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Events"

      assert_patch(show_live, ~p"/events/#{events}/show/edit")

      assert show_live
             |> form("#events-form", events: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#events-form", events: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/events/#{events}")

      html = render(show_live)
      assert html =~ "Events updated successfully"
      assert html =~ "some updated description"
    end
  end
end
