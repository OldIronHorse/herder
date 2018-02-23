defmodule OrderTest do
  use ExUnit.Case, async: true

  test "Intial order is unfilled" do
    {:ok, order} = Herder.Order.start_link(id: 1, side: :borrow, size: 100, rate: 0.35, term: 36, party: self())

    assert %{id: 1, side: :borrow, size: 100, rate: 0.35, term: 36, leaves: 100} =
             Herder.Order.get_state(order)
  end
end
