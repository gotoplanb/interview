defmodule Interview.RolesTest do
  use Interview.DataCase

  alias Interview.Roles

  describe "roles" do
    alias Interview.Roles.Role

    import Interview.RolesFixtures

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Roles.list_roles() == [role]
    end

    test "get_role!/2 returns the role with given id" do
      role = role_fixture()
      assert Roles.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{name: "Software Engineer", description: "Full stack developer role", active: true}

      assert {:ok, %Role{} = role} = Roles.create_role(valid_attrs)
      assert role.name == "Software Engineer"
      assert role.description == "Full stack developer role"
      assert role.active == true
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Roles.create_role(%{name: nil})
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{name: "Senior Engineer", description: "Updated description", active: false}

      assert {:ok, %Role{} = role} = Roles.update_role(role, update_attrs)
      assert role.name == "Senior Engineer"
      assert role.description == "Updated description"
      assert role.active == false
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Roles.update_role(role, %{name: nil})
      assert role == Roles.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Roles.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Roles.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Roles.change_role(role)
    end
  end
end 