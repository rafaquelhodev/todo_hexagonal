defmodule TodoHexagonal.Repo do
  use Ecto.Repo,
    otp_app: :todo_hexagonal,
    adapter: Ecto.Adapters.Postgres
end
