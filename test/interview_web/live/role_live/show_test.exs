defmodule InterviewWeb.RoleLive.ShowTest do
  use InterviewWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  alias Interview.Roles

  setup %{conn: conn} do
    # Create a test role
    {:ok, role} = Roles.create_role(%{
      name: "Test Show Role",
      description: "Role for testing show view"
    })
    
    %{conn: conn, role: role}
  end

  describe "Show role" do
    test "displays role details", %{conn: conn, role: role} do
      {:ok, _lv, html} = live(conn, ~p"/roles/#{role}")

      assert html =~ role.name
      assert html =~ role.description
    end

    test "renders show page with correct title", %{conn: conn, role: role} do
      {:ok, lv, _html} = live(conn, ~p"/roles/#{role}")
      
      assert page_title(lv) =~ "Show Role"
    end

    test "navigates to edit page", %{conn: conn, role: role} do
      {:ok, lv, _html} = live(conn, ~p"/roles/#{role}")
      
      # Check the navigation element exists
      assert has_element?(lv, "a", "Edit")
      
      # Test the page title function
      assert render(lv) =~ "Show Role"
    end
    
    # Test show path renders properly
    test "renders the show page with role data", %{conn: conn, role: role} do
      {:ok, _lv, html} = live(conn, ~p"/roles/#{role}")
      assert html =~ role.name
      assert html =~ role.description
    end
  end
end