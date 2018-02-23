defmodule HerderTest do
  use ExUnit.Case
  doctest Herder

  test "greets the world" do
    assert Herder.hello() == :world
  end
end
