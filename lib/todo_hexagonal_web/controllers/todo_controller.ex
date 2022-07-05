defmodule TodoHexagonalWeb.TodoController do
  use TodoHexagonalWeb, :controller

  alias TodoHexagonal.UseCases

  def create(conn, _todo = %{"description" => description, "due_date" => due_date}) do
    with {:ok, todo} <- UseCases.create_todo(description, due_date) do
      render(conn, "create_todo.json", todo: todo)
    end
  end
end
