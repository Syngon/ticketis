defmodule Ticketis.Event.Subjects do
  import Ecto.Query, warn: false
  alias Ticketis.Repo

  alias Ticketis.Event.Schemas.Subjects

  @doc """
  Returns the list of subjects.

  ## Examples

      iex> list_subjects()
      [%Subjects{}, ...]

  """
  def list_subjects do
    Repo.all(Subjects)
  end

  @doc """
  Gets a single subjects.

  Raises `Ecto.NoResultsError` if the Subjects does not exist.

  ## Examples

      iex> get_subjects!(123)
      %Subjects{}

      iex> get_subjects!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subjects!(id), do: Repo.get!(Subjects, id)

  @doc """
  Creates a subjects.

  ## Examples

      iex> create_subjects(%{field: value})
      {:ok, %Subjects{}}

      iex> create_subjects(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subjects(attrs \\ %{}) do
    %Subjects{}
    |> Subjects.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subjects.

  ## Examples

      iex> update_subjects(subjects, %{field: new_value})
      {:ok, %Subjects{}}

      iex> update_subjects(subjects, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subjects(%Subjects{} = subjects, attrs) do
    subjects
    |> Subjects.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subjects.

  ## Examples

      iex> delete_subjects(subjects)
      {:ok, %Subjects{}}

      iex> delete_subjects(subjects)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subjects(%Subjects{} = subjects) do
    Repo.delete(subjects)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subjects changes.

  ## Examples

      iex> change_subjects(subjects)
      %Ecto.Changeset{data: %Subjects{}}

  """
  def change_subjects(%Subjects{} = subjects, attrs \\ %{}) do
    Subjects.changeset(subjects, attrs)
  end
end
