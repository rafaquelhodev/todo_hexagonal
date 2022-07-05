defmodule TodoHexagonal.Domain.Todo do
  @type t :: %__MODULE__{
          description: String.t(),
          due_date: DateTime.t(),
          done?: boolean()
        }

  defstruct description: "", due_date: nil, done?: false

  @spec create(String.t(), DateTime.t()) :: {:ok, t()} | {:error, String.t()}
  def create(description, due_date = %DateTime{}) do
    case todo_valid?(description, due_date) do
      {true} -> {:ok, %__MODULE__{description: description, due_date: due_date}}
      {false, error} -> {:error, error}
    end
  end

  @spec create(String.t(), String.t()) :: {:ok, t()} | {:error, String.t()}
  def create(description, due_date = %NaiveDateTime{}) do
    case DateTime.from_naive(due_date, "Etc/UTC") do
      {:ok, datetime} -> create(description, datetime)
      {:error, _} -> {:error, "A datetime must be provided"}
    end
  end

  @spec create(String.t(), String.t()) :: {:ok, t()} | {:error, String.t()}
  def create(description, due_date) when is_binary(due_date) do
    case DateTime.from_iso8601(due_date) do
      {:ok, datetime, _offset} -> create(description, datetime)
      {:error, _} -> {:error, "A datetime must be provided"}
    end
  end

  defp todo_valid?(_description = "", _due_date) do
    {false, "A description is required"}
  end

  defp todo_valid?(_description, %DateTime{} = _due_date) do
    {true}
  end

  defp todo_valid?(_description, _due_date) do
    {false, "A datetime must be provided"}
  end
end
