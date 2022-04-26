  def success(conn, _params) do
    render(conn, "success.html")
  end

  def failure(conn, _params) do
    render(conn, "failure.html")
  end
end
