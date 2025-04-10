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

    test "handles validation errors when saving new role", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      assert index_live |> element("a", "New Role") |> render_click()
      assert_patch(index_live, ~p"/roles/new")

      # Submit with invalid data (empty name)
      result = index_live
               |> form("#role-form", role: %{name: "", description: "New Description"})
               |> render_submit()
      
      # Verify the validation error message appears in the result
      assert result =~ "can&#39;t be blank"
    end
    
    test "validates role attributes during edit", %{conn: conn, role: role} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      assert index_live |> element("#roles-#{role.id} a", "Edit") |> render_click()
      assert_patch(index_live, ~p"/roles/#{role}/edit")

      # Submit with invalid data and check result
      result = index_live
               |> form("#role-form", role: %{name: ""})
               |> render_change()
               
      # Verify the validation error message appears in the result
      assert result =~ "can&#39;t be blank"
    end

    test "updates role in listing", %{conn: conn, role: role} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      assert index_live |> element("#roles-#{role.id} a", "Edit") |> render_click() =~
               "Edit Role"

      assert_patch(index_live, ~p"/roles/#{role}/edit")

      # Test validation
      assert index_live
             |> form("#role-form",
               role: %{name: ""}
             )
             |> render_change() =~ "can&#39;t be blank"

      # Test submission with valid data
      assert index_live
             |> form("#role-form",
               role: %{name: "Updated Role", description: "Updated Description"}
             )
             |> render_submit()

      assert_patch(index_live, ~p"/roles")

      html = render(index_live)
      assert html =~ "Role updated successfully"
      assert html =~ "Updated Role"
      assert html =~ "Updated Description"
    end

    test "deletes role in listing", %{conn: conn, role: role} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")

      # Verify the role exists first
      assert has_element?(index_live, "#roles-#{role.id}")
      
      # Delete it
      assert index_live |> element("#roles-#{role.id} a", "Delete") |> render_click()
      
      # Verify it's gone
      refute has_element?(index_live, "#roles-#{role.id}")
      
      # Verify we can't get the role after deletion
      assert_raise Ecto.NoResultsError, fn ->
        Interview.Roles.get_role!(role.id)
      end
    end

    test "shows correct page title for index action", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")
      assert page_title(index_live) =~ "Listing Roles"
    end
    
    test "shows correct page title for new action", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")
      
      index_live |> element("a", "New Role") |> render_click()
      assert page_title(index_live) =~ "New Role"
    end
    
    test "shows correct page title for edit action", %{conn: conn, role: role} do
      {:ok, index_live, _html} = live(conn, ~p"/roles")
      
      index_live |> element("#roles-#{role.id} a", "Edit") |> render_click()
      assert page_title(index_live) =~ "Edit Role"
    end
  end

  defp create_role(_) do
    role = role_fixture()
    %{role: role}
  end
end
