defmodule Ticketis.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :text
      add :image, :string
      add :start_date, :naive_datetime
      add :end_date, :naive_datetime
      add :is_visible, :boolean, default: false, null: false
      add :is_active, :boolean, default: false, null: false
      add :producer_id, references(:users, on_delete: :nothing)
      add :subject_id, references(:subjects, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:producer_id])
    create index(:events, [:subject_id])
    create index(:events, [:category_id])
  end
end
