defmodule TodoHexagonal.Repository.Ports.Todo do
  alias TodoHexagonal.Domain

  @callback insert(String.t(), DateTime.t()) :: {:ok, Domain.Todo.t()} | {:error, String.t()}

  @callback get_all() :: {:ok, list(Domain.Todo.t())} | {:error, String.t()}
end
