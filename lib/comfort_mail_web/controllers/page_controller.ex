defmodule ComfortMailWeb.PageController do
  @moduledoc """
  This controller is used to display simple static sites.
  This controller should not be used for complex sites that needs to receive data.
  """
  use ComfortMailWeb, :controller

  def documentation(conn, _params) do
    render(conn, "documentation.html")
  end
end
