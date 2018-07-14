defmodule GstudyWeb.PageController do
  use GstudyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
