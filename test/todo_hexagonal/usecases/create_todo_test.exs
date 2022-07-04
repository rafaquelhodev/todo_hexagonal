defmodule Todo.Hexagonal.UseCasesTest do
  use ExUnit.Case, async: true
  use TodoHexagonal.DataCase

  alias TodoHexagonal.Domain
  alias TodoHexagonal.UseCases

  describe "create_todo/3" do
    test "should create todo in the database" do
      description = "must by potatoes"
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")

      assert {:ok, todo = %Domain.Todo{}} = UseCases.create_todo(description, due_date)
      assert todo.description == description
      assert todo.due_date == due_date
    end
  end
end
