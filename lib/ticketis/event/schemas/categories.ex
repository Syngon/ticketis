defmodule Ticketis.Event.Schemas.Categories do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :description, :string
    field :name, :string
    field :created_by, :id

    timestamps()
  end

  @doc false
  def changeset(categories, attrs) do
    categories
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
