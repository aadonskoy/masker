defmodule MaskerTest do
  use ExUnit.Case
  doctest Masker

  test "greets the world" do
    assert Masker.hello() == :world
  end
end
