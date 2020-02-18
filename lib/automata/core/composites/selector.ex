defmodule Automaton.Composite.Selector do
  @moduledoc """
    Selector Node (also known as Fallback)

    When the execution of a selector node starts, the node’s children are
    executed in succession from left to right, until a child returning success
    or running is found. Then this message is returned to the parent of the
    selector. It returns failure only when all the children return a status
    failure. The purpose of the selector node is to robustly carry out a task
    that can be performed using several different approaches.

    A Selector will return immediately with a success status code when one of
    its children runs successfully. As long as its children are failing, it will
    keep on trying. If it runs out of children completely, it will return a
    failure status code.
  """
  alias Automaton.{Composite, Behavior}

  defmacro __using__(opts) do
    quote do
      @impl Behavior
      def on_init(state) do
        new_state = Map.put(state, :m_status, :running)
        IO.inspect(["CALL ON_INIT(SEL)", state.m_status, new_state.m_status], label: __MODULE__)

        {:reply, state, new_state}
      end

      @impl Behavior
      def update(state) do
        new_state = Map.put(state, :m_status, :running)
        IO.inspect(["CALL UPDATE(SEL)", state.m_status, new_state.m_status], label: __MODULE__)

        {:reply, state, new_state}
      end

      @impl Behavior
      def on_terminate(status) do
        IO.puts("ON_TERMINATE(SEL)")
        {:ok, status}
      end

      #
      #   @impl Behavior
      #   def update() do
      #     IO.puts("UPDATE SELECTOR")
      #
      #     # Keep going until a child behavior says its running.
      #     # Enum.each %State{} do
      #     #    fn({field, value}) -> IO.puts(value)
      #     # end
      #     # {
      #     #     Status s = (*m_Current)->tick();
      #     #
      #     #     // If the child succeeds, or keeps running, do the same.
      #     #     if (s != BH_FAILURE)
      #     #     {
      #     #         return s;
      #     #     }
      #     #
      #     #     // Hit the end of the array, it didn't end well...
      #     #     if (++m_Current == m_Children.end())
      #     #     {
      #     #         return BH_FAILURE;
      #     #     }
      #     # }
      #     # IO.puts("selector update/0")
      #     # # return status, overidden by user
      #     # {:ok, state}
      #     :running
      #   end
      #
      #   ## Helper Functions
    end
  end
end
