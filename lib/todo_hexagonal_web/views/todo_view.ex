defmodule TodoHexagonalWeb.TodoView do
  use TodoHexagonalWeb, :view

  def render("create_todo.json", %{todo: todo}) do
    %{description: todo.description, due_date: todo.due_date}
  end
end
