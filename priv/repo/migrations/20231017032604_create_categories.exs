defmodule Ticketis.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :description, :string
      add :created_by, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:categories, [:created_by])
  end
end
