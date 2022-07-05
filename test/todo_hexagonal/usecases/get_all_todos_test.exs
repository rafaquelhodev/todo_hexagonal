defmodule Todo.Hexagonal.UseCases.GetAllTodosTest do
  use ExUnit.Case, async: true
  use TodoHexagonal.DataCase

  alias TodoHexagonal.Domain
  alias TodoHexagonal.UseCases

  describe "get_all_todos/0" do
    test "should return all todos in the database" do
      description = "must by potatoes"
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")

      {:ok, _todo1 = %Domain.Todo{}} = UseCases.create_todo(description, due_date)
      {:ok, _todo2 = %Domain.Todo{}} = UseCases.create_todo(description, due_date)

      assert {:ok, todos} = UseCases.get_all_todos()

      assert length(todos) == 2
    end
  end
end
