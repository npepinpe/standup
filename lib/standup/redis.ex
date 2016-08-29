defmodule Standup.Redis do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    config = Application.get_env(:standup, __MODULE__)
    children = [
      :poolboy.child_spec(:redis_pool, config[:pool], config[:redis])
    ]
    supervise(children, strategy: :one_for_one)
  end

  def exec(cmd, args) do
    :poolboy.transaction(:redis_pool, fn(worker) -> :eredis.q(worker, [cmd | args], 5000) end)
  end
end
