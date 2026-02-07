defmodule Predicates do
  @moduledoc """
  """

  @doc """
  Check if the argument can pass through any one of the predicates that we have defined

  ## Examples

      iex> Predicates.pass?("A")
      false

  """
  def pass?(char) do
    predicates = [&lowercase?/1, &digit?/1]
    predicate = fold(predicates)
    predicate.(char)
  end

  defp fold(predicates) when is_list(predicates) do
    fn char ->
      Enum.any?(predicates, fn predicate -> predicate.(char) end)
    end
  end

  defp lowercase?(<<char::utf8>>) do
    char in ?a..?z
  end

  defp digit?(<<char::utf8>>) do
    char in ?0..?9
  end
end
