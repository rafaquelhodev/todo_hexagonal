defmodule TodoHexagonal.UseCases do
  def create_todo(description, due_date) do
    repo().insert(description, due_date)
  end

  def get_all_todos() do
    repo().get_all()
  end

  defp repo do
    Application.get_env(:todo_hexagonal, :repository, TodoHexagonal.Repository.EctoTodo)
  end
end
