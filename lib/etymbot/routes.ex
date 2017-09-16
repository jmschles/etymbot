defmodule Etymbot.Routes do
  import Plug.Conn
  use Plug.Router

  plug Plug.Logger
  plug Etymbot.Authenticate
  plug Etymbot.Responder

  plug :match
  plug :dispatch

  get "/etym" do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, encoded_response(conn))
  end

  match _ do
    send_resp(conn, 404, "WAT")
  end

  defp encoded_response(conn) do
    Poison.Encoder.encode(%{text: conn.assigns[:response], response_type: "in_channel"}, [])
  end
end
