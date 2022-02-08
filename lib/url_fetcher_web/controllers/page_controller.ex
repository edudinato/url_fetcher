defmodule UrlFetcherWeb.PageController do
  use UrlFetcherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
