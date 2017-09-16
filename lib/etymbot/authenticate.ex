defmodule Etymbot.Authenticate do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    if verify_token(conn) do
      conn
    else
      conn
      |> send_resp(401, "Invalid token")
      |> halt
    end
  end

  defp verify_token(conn) do
    Enum.member?(valid_tokens(), passed_token(conn))
  end

  defp passed_token(conn) do
    fetch_query_params(conn).params["token"]
  end

  defp valid_tokens do
    [
      System.get_env("SM_SLACK_ETYM_TOKEN")
    ]
  end
end
