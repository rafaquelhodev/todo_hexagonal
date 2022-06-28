defmodule TodoHexagonal.Translators.GenericTest do
  use ExUnit.Case, async: true

  alias TodoHexagonal.Domain
  alias TodoHexagonal.EctoModel
  alias TodoHexagonal.Translators

  describe "translate/3" do
    test "should translate todo ecto model to domain" do
      due_date = DateTime.from_naive!(~N[2018-11-15 10:00:00], "Etc/UTC")

      ecto_model =
        EctoModel.Todo.changeset(%EctoModel.Todo{}, %{
          "description" => "buy something today",
          "due_date" => due_date
        })

      relation_map = %{description: :description, due_date: :due_date}

      todo_domain =
        %Domain.Todo{} =
        Translators.Generic.translate(ecto_model.changes, Domain.Todo, relation_map)

      assert Map.get(todo_domain, :description) == "buy something today"
      assert Map.get(todo_domain, :due_date) == due_date
    end
  end
end
