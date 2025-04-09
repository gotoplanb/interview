defmodule Interview.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :type, :string, null: false

      timestamps()
    end

    # Add an index on the type field since we'll be querying by it
    create index(:users, [:type])
  end
end
