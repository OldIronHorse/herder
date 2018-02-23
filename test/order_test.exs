defmodule OrderTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, order} =
      Herder.Order.start_link(
        id: 1,
        side: :borrow,
        size: 100,
        rate: 0.35,
        term: 36,
        party: self()
      )
    {:ok, order: order}
  end

  test "Intial order is unfilled", %{order: order} do
    assert %{id: 1, side: :borrow, size: 100, rate: 0.35, term: 36, leaves: 100} =
             Herder.Order.get_state(order)
  end

  test "Filling an order decerments its leaves quantity", %{order: order} do
    Herder.Order.fill(order, 30)
    assert %{size: 100, leaves: 70} = Herder.Order.get_state(order)
  end

  test "A fully filled order is complete", %{order: order} do
    Herder.Order.fill(order, 100)
    assert Herder.Order.is_complete(order)
  end
end
