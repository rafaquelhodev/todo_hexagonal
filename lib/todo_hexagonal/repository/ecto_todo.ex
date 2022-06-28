defmodule TodoHexagonal.Repository.EctoTodo do
  @behaviour TodoHexagonal.Repository.Ports.Todo

  alias TodoHexagonal.Domain
  alias TodoHexagonal.EctoModel
  alias TodoHexagonal.Repo
  alias TodoHexagonal.Translators

  @impl true
  def insert(description, due_date) do
    {:ok, todo} = Domain.Todo.create(description, due_date)

    relation_map = %{description: :description, due_date: :due_date}

    case %EctoModel.Todo{}
         |> EctoModel.Todo.changeset(%{description: todo.description, due_date: todo.due_date})
         |> Repo.insert() do
      {:ok, ecto_todo} ->
        {:ok, Translators.Generic.translate(ecto_todo, Domain.Todo, relation_map)}

      {:error, _} = err ->
        err
    end
  end
end
