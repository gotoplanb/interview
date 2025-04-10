defmodule Interview.DataCaseTest do
  use Interview.DataCase, async: true

  describe "errors_on" do
    test "translates changeset errors into a map of messages" do
      # Create a changeset with validation errors
      changeset = 
        {%{}, %{name: :string}}
        |> Ecto.Changeset.cast(%{}, [:name])
        |> Ecto.Changeset.validate_required([:name])

      # Use the errors_on function to convert errors
      error_map = errors_on(changeset)
      
      # Verify the conversion
      assert error_map.name == ["can't be blank"]
    end

    test "handles translation with interpolated values" do
      # Create a changeset with interpolation in the error message
      changeset =
        {%{}, %{age: :integer}}
        |> Ecto.Changeset.cast(%{age: 10}, [:age])
        |> Ecto.Changeset.validate_number(:age, greater_than: 18, message: "must be greater than %{count}")

      # Use the errors_on function to convert errors with interpolation
      error_map = errors_on(changeset)
      
      # Verify interpolation was handled correctly
      assert error_map.age == ["must be greater than count"]
    end
  end
end