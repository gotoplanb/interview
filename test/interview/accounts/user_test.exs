defmodule Interview.Accounts.UserTest do
  use Interview.DataCase

  alias Interview.Accounts.User

  describe "user" do
    @valid_attrs %{name: "Testy McTesterson", type: :employee}
    @invalid_attrs %{name: nil, type: nil}

    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "type must be either :employee or :candidate" do
      attrs = Map.put(@valid_attrs, :type, :invalid_type)
      changeset = User.changeset(%User{}, attrs)
      {field, {message, _}} = hd(changeset.errors)
      assert field == :type
      assert message == "is invalid"
      refute changeset.valid?
    end
  end
end 