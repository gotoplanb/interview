defmodule Interview.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :type, Ecto.Enum, values: [:employee, :candidate]

    timestamps()
  end

  @doc """
  Creates a user changeset.
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :type])
    |> validate_required([:name, :type])
    |> validate_inclusion(:type, [:employee, :candidate])
  end
end
