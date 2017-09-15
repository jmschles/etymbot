defmodule Etymbot.Routes do
  use Plug.Router

  plug Etymbot.Authenticate, [token: "token"]
  plug :match
  plug :dispatch

  get "/" do
    data = %{message: "Hello World!"}
    conn
      |> put_resp_header("content-type","application/json")
      |> send_resp(200, Poison.encode!(data))
  end

  match _ do
    send_resp(conn, 404, "WAT")
  end
end
