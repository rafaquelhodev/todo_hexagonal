defmodule TodoHexagonal.Domain.TodoTest do
  use ExUnit.Case, async: true

  alias TodoHexagonal.Domain.Todo

  describe "Create/2" do
    test "shoud create a todo" do
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")
      assert {:ok, %Todo{} = todo} = Todo.create("buy groceries", due_date)
      assert todo.description == "buy groceries"
      assert todo.due_date == due_date
      assert todo.done? == false
    end

    test "should fail to create a todo when no description is given" do
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")
      assert {:error, reason} = Todo.create("", due_date)
      assert reason == "A description is required"
    end

    test "should convert naive datetime to datetime" do
      assert {:ok, %Todo{} = todo} = Todo.create("buy groceries", ~N[2018-11-15 10:00:00])
      assert {:ok, todo.due_date} == DateTime.from_naive(~N[2018-11-15 10:00:00], "Etc/UTC")
    end

    test "should convert string 'due_date' into datetime" do
      assert {:ok, %Todo{} = todo} = Todo.create("buy groceries", "2018-11-15 10:00:00Z")
      assert {:ok, todo.due_date} == DateTime.new(~D[2018-11-15], ~T[10:00:00], "Etc/UTC")
    end

    test "should fail to create a todo" do
      assert {:error, reason} = Todo.create("buy groceries", "not a datetime")
      assert reason == "A datetime must be provided"
    end
  end

  describe "Create/3" do
    test "shoud create a todo already done" do
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")
      assert {:ok, %Todo{} = todo} = Todo.create("buy groceries", due_date, true)
      assert todo.description == "buy groceries"
      assert todo.due_date == due_date
      assert todo.done? == true
    end

    test "should convert string 'due_date' into datetime already done" do
      assert {:ok, %Todo{} = todo} = Todo.create("buy groceries", "2018-11-15 10:00:00Z", true)
      assert {:ok, todo.due_date} == DateTime.new(~D[2018-11-15], ~T[10:00:00], "Etc/UTC")
      assert todo.done? == true
    end
  end
end
