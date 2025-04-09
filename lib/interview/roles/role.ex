defmodule Interview.Roles.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    field :description, :string
    field :active, :boolean, default: true

    timestamps()
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description, :active])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
