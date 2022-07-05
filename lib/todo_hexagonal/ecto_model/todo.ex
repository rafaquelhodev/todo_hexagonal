defmodule TodoHexagonal.EctoModel.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :description, :string
    field :due_date, :utc_datetime
    field :done?, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:description, :due_date, :done?])
    |> validate_required([:description, :due_date])
  end
end
