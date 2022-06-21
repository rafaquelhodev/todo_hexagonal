defmodule TodoHexagonal.Domain.TodoTest do
  use ExUnit.Case, async: true

  alias TodoHexagonal.Domain.Todo

  describe "Create/2" do
    test "shoud create a todo" do
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")
      assert {:ok, %Todo{} = todo} = Todo.create("buy groceries", due_date)
      assert todo.description == "buy groceries"
      assert todo.due_date == due_date
    end

    test "should fail to create a todo when no description is given" do
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")
      assert {:error, reason} = Todo.create("", due_date)
      assert reason == "A description is required"
    end

    test "should fail to create a todo" do
      assert {:error, reason} = Todo.create("buy groceries", ~N[2018-11-15 10:00:00])
      assert reason == "A datetime must be provided"
    end
  end

end
