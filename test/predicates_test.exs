defmodule PredicatesTest do
  use ExUnit.Case
  doctest Predicates

  test "char `a` should pass" do
    assert Predicates.pass?("a") == true
  end

  test "char `7` should  pass" do
    assert Predicates.pass?("7") == true
  end

  test "char `,` should not pass" do
    assert Predicates.pass?(",") == false
  end

  test "char `A` should not pass" do
    assert Predicates.pass?("A") == false
  end
end
