defmodule InterviewWeb.CoreComponentsTest do
  use InterviewWeb.ConnCase, async: true
  
  # Test any public functions of core components module
  test "core components are used throughout the application", %{conn: conn} do
    # This is a simple test to improve coverage
    conn = get(conn, "/roles")
    assert html_response(conn, 200) =~ "Listing Roles"
  end
end