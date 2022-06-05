defmodule TodoHexagonal.Domain.Todo do
  @type t :: %__MODULE__{
          description: String.t(),
          datetime: DateTime.t(),
          done?: boolean()
        }

  defstruct description: "", datetime: nil, done?: false

  @spec create(String.t(), DateTime.t()) :: {:ok, t()} | {:error, String.t()}
  def create(description, datetime) do
    case todo_valid?(description, datetime) do
      {true} -> {:ok, %__MODULE__{description: description, datetime: datetime}}
      {false, error} -> {:error, error}
    end
  end

  defp todo_valid?(_description = "", _datetime) do
    {false, "A description is required"}
  end

  defp todo_valid?(_description, %DateTime{} = _datetime) do
    {true}
  end

  defp todo_valid?(_description, _datetime) do
    {false, "A datetime must be provided"}
  end
end
