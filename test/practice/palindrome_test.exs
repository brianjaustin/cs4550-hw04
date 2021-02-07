defmodule Practice.PalindromeTest do
  use ExUnit.Case
  doctest Practice.Palindrome
  import Practice.Palindrome

  test "palindrome?('') is true" do
    assert palindrome?("")
  end

  test "palindrome?('foobar') is false" do
    refute palindrome?("foobar")
  end

  test "palindrome?('abba') is true" do
    assert palindrome?("abba")
  end

  test "palindrome?('Abba') is true" do
    assert palindrome?("Abba")
  end
end
