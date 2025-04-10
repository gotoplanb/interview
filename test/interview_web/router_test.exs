defmodule InterviewWeb.RouterTest do
  use InterviewWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Listing Roles"
  end

  test "GET /roles", %{conn: conn} do
    conn = get(conn, "/roles")
    assert html_response(conn, 200) =~ "Listing Roles"
  end

  test "GET /roles/new", %{conn: conn} do
    conn = get(conn, "/roles/new")
    assert html_response(conn, 200) =~ "New Role"
  end

  test "routes are correctly defined" do
    # Test that the routes are defined
    routes = InterviewWeb.Router.__routes__()
    
    # Check for specific routes
    assert Enum.any?(routes, fn r -> r.path == "/" end)
    assert Enum.any?(routes, fn r -> r.path == "/roles" end)
    assert Enum.any?(routes, fn r -> r.path == "/roles/new" end)
    assert Enum.any?(routes, fn r -> r.path == "/roles/:id/edit" end)
    assert Enum.any?(routes, fn r -> r.path == "/roles/:id" end)
    assert Enum.any?(routes, fn r -> r.path == "/roles/:id/show/edit" end)
  end
end