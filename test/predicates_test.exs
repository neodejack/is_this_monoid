defmodule PredicatesTest do
  use ExUnit.Case
  import Predicates
  doctest Predicates

  def base_predicate() do
    fold([&lowercase?/1, &digit?/1], &Enum.any?/2)
  end

  test "char `a` should pass" do
    assert base_predicate().("a") == true
  end

  test "char `7` should  pass" do
    assert base_predicate().("7") == true
  end

  test "char `,` should not pass" do
    assert base_predicate().(",") == false
  end

  test "char `A` should not pass" do
    assert base_predicate().("A") == false
  end

  test "composing predicates" do
    assert false == base_predicate() |> then(& &1.("A"))

    assert true ==
             base_predicate()
             |> then(fn base -> fold([(&uppercase?/1) | base], &Enum.any?/2) end)
             |> then(& &1.("A"))
  end
end
