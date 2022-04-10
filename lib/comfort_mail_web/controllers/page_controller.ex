defmodule ComfortMailWeb.PageController do
  use ComfortMailWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
