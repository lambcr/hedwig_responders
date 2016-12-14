defmodule HedwigResponders.Cache.StandupListTest do
  use ExUnit.Case
  doctest HedwigResponders.Cache.StandupList

  import HedwigResponders.Cache.StandupList

  setup do
    Cachex.clear(cache_name)
    :ok
  end

  test "show with nil cache" do
    assert [] == show
  end

  test "show with existing cache from set" do
    set([1,2,3,4])
    assert [1,2,3,4] == show
  end

  test "add a name" do
    add "Bender"
    assert Enum.member?(show, "Bender"), show
  end

  test "remove a name" do
    add "Bender"
    remove "Bender"
    assert [] == show
  end
end
