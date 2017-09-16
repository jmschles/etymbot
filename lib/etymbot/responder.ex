require IEx

defmodule Etymbot.Responder do
  import Plug.Conn

  @base_url "http://www.etymonline.com/index.php"

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> parse_command
    |> make_etymonline_request
    |> parse_etymonline_response
    |> assign_response(conn)
  end

  defp parse_command(conn) do
    fetch_query_params(conn).params["text"]
  end

  defp make_etymonline_request(word) do
    HTTPoison.get(@base_url <> "?term=" <> word)
  end

  defp parse_etymonline_response({:ok, html_response}) do
    html_body = html_response.body
    if String.contains?(html_body, "No matching terms found") do
      "No matching terms found :boo:"
    else
      headings = parse_headings(html_body)
      etymologies = parse_etymologies(html_body)
      [headings, etymologies] |> format_response
    end
  end

  defp parse_etymonline_response({:error, _}) do
    "Error contacting etymonline :lame:"
  end

  defp assign_response(response, conn) do
    assign(conn, :response, response)
  end

  defp parse_etymologies(html_body) do
    html_body
    |> Floki.find("#dictionary dd")
    |> Enum.map(&(elem(&1, 2)))
    |> Enum.map(&(concat_gnarly_text_together(&1)))
  end

  defp parse_headings(html_body) do
    html_body
    |> Floki.find("#dictionary dt a[href*=\"/index.php\"")
    |> Enum.map(&(elem(&1,2)))
    |> List.flatten
  end

  defp format_response([headings, etymologies]) do
    [headings, etymologies]
    |> List.zip
    |> Enum.map(&("*" <> elem(&1,0) <> "*: " <> elem(&1, 1)))
    |> Enum.join("\n\n")
  end

  defp concat_gnarly_text_together(marked_up_text) do
    marked_up_text
    |> Enum.map(&(get_text(&1)))
    |> Enum.join("")
  end

  defp get_text(text_element) when is_tuple(text_element) do
    elem(text_element, 2) |> Enum.at(0)
  end

  defp get_text(text_element), do: text_element
end
