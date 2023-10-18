defmodule Ticketis.EventFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticketis.Event` context.
  """

  @doc """
  Generate a events.
  """
  def events_fixture(attrs \\ %{}) do
    {:ok, events} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_date: ~N[2023-10-16 03:28:00],
        image: "some image",
        is_active: true,
        is_visible: true,
        name: "some name",
        start_date: ~N[2023-10-16 03:28:00]
      })
      |> Ticketis.Event.create_events()

    events
  end
end
