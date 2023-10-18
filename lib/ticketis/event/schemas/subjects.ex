defmodule Ticketis.Event.Schemas.Subjects do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :description, :string
    field :name, :string
    field :created_by, :id

    timestamps()
  end

  @doc false
  def changeset(subjects, attrs) do
    subjects
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
