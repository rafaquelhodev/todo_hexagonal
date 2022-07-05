defmodule TodoHexagonal.Repo.Migrations.AddDoneColumn do
  use Ecto.Migration

  def change do
    alter table("todos") do
      add :done?, :boolean, default: false
    end
  end
end
