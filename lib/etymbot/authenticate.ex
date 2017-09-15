defmodule Etymbot.Authenticate do
  def init(opts), do: opts

  def call(conn, opts) do
    conn
    |> get_auth_headers
    |> authenticate(opts[:token])
  end

  def get_auth_headers(conn) do
    {conn, Plug.Conn.get_req_header(conn, "authorization")}
  end

  def authenticate({conn, [token]}, token) do
    conn
  end

  def authenticate({conn, _}, token) do
    conn
    |> Plug.Conn.send_resp(401, "Not Authorised")
    |> Plug.Conn.halt
  end
end
