defmodule TruckExpenseSystemWeb.PageController do
  use TruckExpenseSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
