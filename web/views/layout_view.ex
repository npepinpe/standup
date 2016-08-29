defmodule Standup.LayoutView do
  import Plug.Conn
  use Standup.Web, :view

  def stylesheets do
    Access.get(assigns, :stylesheets, [])
  end

  def title do
    Access.get(assigns, :title, "Standups")
  end

  def javascripts do
    Access.get(assigns, :javascripts, [])
  end
end
