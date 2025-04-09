defmodule InterviewWeb.RoleLive.IndexTest do
  use InterviewWeb.ConnCase

  import Phoenix.LiveViewTest
  import Interview.RolesFixtures

  describe "Index" do
    setup [:create_role]

    test "lists all roles", %{conn: conn, role: role} do
      {:ok, _index_live, html} = live(conn, ~p"/roles")

      assert html =~ "Listing Roles"
      assert html =~ role.name
      assert html =~ role.description
    end

    test "saves new role", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      assert index_live |> element("a", "New Role") |> render_click() =~
               "New Role"

      assert_patch(index_live, ~p"/roles/new")

      assert index_live
             |> form("#role-form", role: %{name: "New Role", description: "New Description"})
             |> render_submit()

      assert_patch(index_live, ~p"/roles")

      html = render(index_live)
      assert html =~ "Role created successfully"
    end

    test "updates role in listing", %{conn: conn, role: role} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      assert index_live |> element("#roles-#{role.id} a", "Edit") |> render_click() =~
               "Edit Role"

      assert_patch(index_live, ~p"/roles/#{role}/edit")

      assert index_live
             |> form("#role-form", role: %{name: "Updated Role", description: "Updated Description"})
             |> render_submit()

      assert_patch(index_live, ~p"/roles")

      html = render(index_live)
      assert html =~ "Role updated successfully"
    end

    test "deletes role in listing", %{conn: conn, role: role} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      assert index_live |> element("#roles-#{role.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#roles-#{role.id}")
    end
  end

  defp create_role(_) do
    role = role_fixture()
    %{role: role}
  end
end 