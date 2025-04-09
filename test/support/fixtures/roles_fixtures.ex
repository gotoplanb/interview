defmodule Interview.RolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Interview.Roles` context.
  """

  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "Software Engineer",
        description: "Full stack developer role",
        active: true
      })
      |> Interview.Roles.create_role()

    role
  end
end 