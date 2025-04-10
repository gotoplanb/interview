defmodule Interview.ApplicationTest do
  use Interview.DataCase, async: true

  test "application is running with required processes" do
    # Test that the application is running by checking essential processes
    assert Process.whereis(Interview.Repo) != nil
    assert Process.whereis(InterviewWeb.Endpoint) != nil
    assert Process.whereis(Interview.PubSub) != nil
    
    # Test that config_change function works
    assert Interview.Application.config_change(%{}, %{}, []) == :ok
  end
end