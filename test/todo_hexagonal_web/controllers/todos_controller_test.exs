defmodule TodoHexagonalWeb.TodosControllerTest do
  use ExUnit.Case, async: true

  use TodoHexagonalWeb.ConnCase

  alias TodoHexagonal.Domain
  alias TodoHexagonal.UseCases

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "must create a new todo", %{conn: conn} do
      params = %{
        "description" => "must buy groceries",
        "due_date" => "2018-11-15 10:00:00Z"
      }

      conn = post(conn, Routes.todo_path(conn, :create, params))

      assert {:ok, [_todo = %Domain.Todo{}]} = UseCases.get_all_todos()

      assert json_response(conn, 200) == %{
               "description" => "must buy groceries",
               "due_date" => "2018-11-15T10:00:00Z"
             }
    end
  end
end
