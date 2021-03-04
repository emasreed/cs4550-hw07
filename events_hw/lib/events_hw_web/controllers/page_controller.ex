defmodule EventsHwWeb.PageController do
  use EventsHwWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
