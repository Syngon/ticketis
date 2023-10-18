defmodule Ticketis.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ticketis.Events` context.
  """

  @doc """
  Generate a subjects.
  """
  def subjects_fixture(attrs \\ %{}) do
    {:ok, subjects} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Ticketis.Events.create_subjects()

    subjects
  end

  @doc """
  Generate a categories.
  """
  def categories_fixture(attrs \\ %{}) do
    {:ok, categories} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Ticketis.Events.create_categories()

    categories
  end
end
