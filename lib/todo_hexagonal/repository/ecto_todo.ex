defmodule TodoHexagonal.Repository.EctoTodo do
  @behaviour TodoHexagonal.Repository.Ports.Todo

  alias TodoHexagonal.Domain
  alias TodoHexagonal.EctoModel
  alias TodoHexagonal.Repo
  alias TodoHexagonal.Translators

  @domain_translation %{description: :description, due_date: :due_date, done?: :done?}

  @impl true
  def insert(description, due_date, done? \\ false) do
    {:ok, todo} = Domain.Todo.create(description, due_date, done?)

    case %EctoModel.Todo{}
         |> EctoModel.Todo.changeset(%{
           description: todo.description,
           due_date: todo.due_date,
           done?: done?
         })
         |> Repo.insert() do
      {:ok, ecto_todo} ->
        {:ok, Translators.Generic.translate(ecto_todo, Domain.Todo, @domain_translation)}

      {:error, _} = err ->
        err
    end
  end

  @impl true
  def get_all() do
    all_todos =
      Repo.all(EctoModel.Todo)
      |> Enum.map(&Translators.Generic.translate(&1, Domain.Todo, @domain_translation))

    {:ok, all_todos}
  end
end
