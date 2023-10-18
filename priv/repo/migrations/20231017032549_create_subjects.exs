defmodule Ticketis.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
      add :description, :string
      add :created_by, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:subjects, [:created_by])
  end
end
