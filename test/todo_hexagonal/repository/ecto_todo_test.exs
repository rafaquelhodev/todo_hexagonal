defmodule TodoHexagonal.Repository.EctoTodoTest do
  use ExUnit.Case, async: true
  use TodoHexagonal.DataCase

  alias TodoHexagonal.Repository.EctoTodo

  describe "Insert/2" do
    test "should insert a todo in the database" do
      description = "must by potatoes"
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")

      assert {:ok, todo} = EctoTodo.insert(description, due_date)
    end
  end
end
