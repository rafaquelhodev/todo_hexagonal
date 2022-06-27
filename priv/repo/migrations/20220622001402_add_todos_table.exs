defmodule TodoHexagonal.Repo.Migrations.AddTodosTable do
  use Ecto.Migration

  def change do
    create table("todos") do
      add :description, :string
      add :due_date, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
