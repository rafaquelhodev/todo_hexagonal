defmodule TodoHexagonal.Repository.EctoTodo do
  @behaviour TodoHexagonal.Repository.Ports.Todo

  alias TodoHexagonal.Domain
  alias TodoHexagonal.EctoModel
  alias TodoHexagonal.Repo

  @impl true
  def insert(description, due_date) do
    {:ok, todo} = Domain.Todo.create(description, due_date)

    %EctoModel.Todo{}
    |> EctoModel.Todo.changeset(%{description: todo.description, due_date: todo.due_date})
    |> Repo.insert()
  end
end
