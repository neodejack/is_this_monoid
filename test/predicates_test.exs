defmodule PredicatesTest do
  use ExUnit.Case
  import Predicates

  defp base_predicate() do
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
             |> then(fn base -> fold([&uppercase?/1, base], &Enum.any?/2) end)
             |> then(& &1.("A"))
  end

  test "composing predicates with different enum_func" do
    either_lower_or_digit = fold([&lowercase?/1, &digit?/1], &Enum.any?/2)
    assert true == either_lower_or_digit.("6")
    assert true == either_lower_or_digit.("a")
    assert false == either_lower_or_digit.("A")

    either_upper_or_digit = fold([&uppercase?/1, &digit?/1], &Enum.any?/2)
    assert true == either_upper_or_digit.("6")
    assert true == either_upper_or_digit.("A")
    assert false == either_upper_or_digit.("a")

    intersect = fold([either_lower_or_digit, either_upper_or_digit], &Enum.all?/2)
    assert true == intersect.("7")
    assert false == intersect.("A")
    assert false == intersect.("a")
  end

  test "identity element" do
    refute "what is an identity element to my monoid???"
  end
end
