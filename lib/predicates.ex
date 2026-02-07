defmodule Predicates do
  @moduledoc """
  a few predicates function
  and a fold operation that combines these predicates function into a single function
  """

  @spec fold([function()], function()) :: (String.t() -> boolean())
  def fold(predicates, enum_func) when is_list(predicates) do
    fn char ->
      enum_func.(predicates, fn predicate -> predicate.(char) end)
    end
  end

  def lowercase?(<<char::utf8>>) do
    char in ?a..?z
  end

  def uppercase?(<<char::utf8>>) do
    char in ?A..?Z
  end

  def digit?(<<char::utf8>>) do
    char in ?0..?9
  end
end
