defmodule InterviewWeb.RoleLive.FormComponentTest do
  use InterviewWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Interview.RolesFixtures

  @live_view_test_role %{
    name: "Test Role",
    description: "Test Description"
  }

  describe "Form Component" do
    test "renders form", %{conn: conn} do
      {:ok, lv, _html} = live(conn, "/roles")
      
      assert lv |> element("a", "New Role") |> render_click() =~
               "New Role"

      html = render(lv)
      assert html =~ "Name"
      assert html =~ "Description"
    end

    test "validates required fields", %{conn: conn} do
      {:ok, lv, _html} = live(conn, "/roles")
      
      assert lv |> element("a", "New Role") |> render_click() =~
               "New Role"

      result =
        lv
        |> form("#role-form", role: %{name: "", description: ""})
        |> render_submit()

      assert result =~ "can&#39;t be blank"
    end

    test "creates a new role", %{conn: conn} do
      {:ok, lv, _html} = live(conn, "/roles")
      
      assert lv |> element("a", "New Role") |> render_click() =~
               "New Role"

      lv
      |> form("#role-form", role: @live_view_test_role)
      |> render_submit()

      assert_patch(lv, "/roles")
      html = render(lv)
      assert html =~ "Role created successfully"
      assert html =~ @live_view_test_role.name
      assert html =~ @live_view_test_role.description
    end
  end
end 