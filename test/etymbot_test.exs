defmodule EtymbotTest do
  use ExUnit.Case
  doctest Etymbot

  test "greets the world" do
    assert Etymbot.hello() == :world
  end
end
