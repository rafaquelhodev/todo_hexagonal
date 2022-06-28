defmodule TodoHexagonal.Translators.Generic do
  def translate(old_model, target_module, dictionary) do
    transcription = struct(target_module)

    Enum.reduce(dictionary, transcription, fn {key, translated_key}, acc ->
      value = Map.get(old_model, key)
      Map.put(acc, translated_key, value)
    end)
  end
end
