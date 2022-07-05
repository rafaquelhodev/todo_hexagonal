defmodule TodoHexagonal.Repository.EctoTodoTest do
  use ExUnit.Case, async: true
  use TodoHexagonal.DataCase

  alias TodoHexagonal.Domain
  alias TodoHexagonal.Repository.EctoTodo

  describe "Insert/2" do
    test "should insert a todo in the database" do
      description = "must by potatoes"
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")

      assert {:ok, todo = %Domain.Todo{}} = EctoTodo.insert(description, due_date)
      assert todo.description == description
      assert todo.due_date == due_date
      assert todo.done? == false
    end

    test "should insert a todo already done in the database" do
      description = "must by potatoes"
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")

      assert {:ok, todo = %Domain.Todo{}} = EctoTodo.insert(description, due_date, true)
      assert todo.description == description
      assert todo.due_date == due_date
      assert todo.done? == true
    end
  end
end
