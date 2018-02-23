defmodule Herder.Order do
  use GenServer
  require Logger

  defmodule State do
    defstruct [:id, :side, :size, :rate, :term, :leaves, :party]
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(id: id, side: side, size: size, rate: rate, term: term, party: party) do
    {
      :ok, 
      %Herder.Order.State{
        id: id,
        side: side,
        rate: rate,
        size: size,
        leaves: size,
        term: term,
        party: party
      }
    }
  end 

  def get_state(order) do
    GenServer.call(order, :get_state)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
