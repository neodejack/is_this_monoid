defmodule Predicates do
  @moduledoc """
  a few predicates function
  and a fold operation that combines these predicates function into a single function
  """

  @type predicate_function :: (String.t() -> boolean())
  @type enum_function :: ([predicate_function()], (predicate_function() -> boolean()) ->
                            boolean())

  @spec fold([predicate_function()], enum_function()) :: predicate_function()
  def fold(predicates, enum_func) when is_list(predicates) do
    fn char ->
      enum_func.(predicates, fn predicate -> predicate.(char) end)
    end
  end

  @spec lowercase?(String.t()) :: boolean()
  def lowercase?(<<char::utf8>>) do
    char in ?a..?z
  end

  @spec uppercase?(String.t()) :: boolean()
  def uppercase?(<<char::utf8>>) do
    char in ?A..?Z
  end

  @spec digit?(String.t()) :: boolean()
  def digit?(<<char::utf8>>) do
    char in ?0..?9
  end
end
