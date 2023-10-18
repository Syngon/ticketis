defmodule Ticketis.EventsTest do
  use Ticketis.DataCase

  alias Ticketis.Events

  describe "subjects" do
    alias Ticketis.Events.Subjects

    import Ticketis.EventsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_subjects/0 returns all subjects" do
      subjects = subjects_fixture()
      assert Events.list_subjects() == [subjects]
    end

    test "get_subjects!/1 returns the subjects with given id" do
      subjects = subjects_fixture()
      assert Events.get_subjects!(subjects.id) == subjects
    end

    test "create_subjects/1 with valid data creates a subjects" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Subjects{} = subjects} = Events.create_subjects(valid_attrs)
      assert subjects.description == "some description"
      assert subjects.name == "some name"
    end

    test "create_subjects/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_subjects(@invalid_attrs)
    end

    test "update_subjects/2 with valid data updates the subjects" do
      subjects = subjects_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Subjects{} = subjects} = Events.update_subjects(subjects, update_attrs)
      assert subjects.description == "some updated description"
      assert subjects.name == "some updated name"
    end

    test "update_subjects/2 with invalid data returns error changeset" do
      subjects = subjects_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_subjects(subjects, @invalid_attrs)
      assert subjects == Events.get_subjects!(subjects.id)
    end

    test "delete_subjects/1 deletes the subjects" do
      subjects = subjects_fixture()
      assert {:ok, %Subjects{}} = Events.delete_subjects(subjects)
      assert_raise Ecto.NoResultsError, fn -> Events.get_subjects!(subjects.id) end
    end

    test "change_subjects/1 returns a subjects changeset" do
      subjects = subjects_fixture()
      assert %Ecto.Changeset{} = Events.change_subjects(subjects)
    end
  end

  describe "categories" do
    alias Ticketis.Events.Categories

    import Ticketis.EventsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_categories/0 returns all categories" do
      categories = categories_fixture()
      assert Events.list_categories() == [categories]
    end

    test "get_categories!/1 returns the categories with given id" do
      categories = categories_fixture()
      assert Events.get_categories!(categories.id) == categories
    end

    test "create_categories/1 with valid data creates a categories" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Categories{} = categories} = Events.create_categories(valid_attrs)
      assert categories.description == "some description"
      assert categories.name == "some name"
    end

    test "create_categories/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_categories(@invalid_attrs)
    end

    test "update_categories/2 with valid data updates the categories" do
      categories = categories_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Categories{} = categories} = Events.update_categories(categories, update_attrs)
      assert categories.description == "some updated description"
      assert categories.name == "some updated name"
    end

    test "update_categories/2 with invalid data returns error changeset" do
      categories = categories_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_categories(categories, @invalid_attrs)
      assert categories == Events.get_categories!(categories.id)
    end

    test "delete_categories/1 deletes the categories" do
      categories = categories_fixture()
      assert {:ok, %Categories{}} = Events.delete_categories(categories)
      assert_raise Ecto.NoResultsError, fn -> Events.get_categories!(categories.id) end
    end

    test "change_categories/1 returns a categories changeset" do
      categories = categories_fixture()
      assert %Ecto.Changeset{} = Events.change_categories(categories)
    end
  end
end
