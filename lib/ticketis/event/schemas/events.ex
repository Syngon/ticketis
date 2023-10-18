defmodule Ticketis.Event.Schemas.Events do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :end_date, :naive_datetime
    field :image, :string
    field :is_active, :boolean, default: false
    field :is_visible, :boolean, default: false
    field :name, :string
    field :start_date, :naive_datetime
    field :producer_id, :id
    field :subject_id, :id
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(events, attrs) do
    events
    |> cast(attrs, [:name, :description, :image, :start_date, :end_date, :is_visible, :is_active])
    |> validate_required([:name, :description, :image, :start_date, :end_date, :is_visible, :is_active])
  end
end
