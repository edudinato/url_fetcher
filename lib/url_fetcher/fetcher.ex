defmodule UrlFetcher.Fetcher do
  @http_client Application.compile_env!(:url_fetcher, :http_client)

  @doc """
    Fetch a given 'url' and finds another URLs inside <img> and <a> tags of the page

    ## Examples
      iex> UrlFetcher.Fetcher.fetch("https://foo.com")
      {:ok,
        %{
          assets: ["https://foo.com/image.png"],
          links: ["https://foo.com/link/to/uri"]
        }
      }

      iex> UrlFetcher.Fetcher.fetch("https://bah.com)
      {:error, :timeout}

  """
  @spec fetch(url :: String.t()) :: {:ok, map()} | {:error, atom()}
  def fetch(url) do
    with {:ok, response} <- @http_client.get(url), do: fetch_from_response(response)
  end

  defp fetch_from_response(response) do
    with {:ok, document} <- Floki.parse_document(response.body) do
      {:ok,
       %{
         assets: get_attribute_array(document, "img", "src"),
         links: get_attribute_array(document, "a", "href")
       }}
    end
  end

  defp get_attribute_array(document, tag, attribute) do
    Floki.find(document, tag)
    |> Floki.attribute(attribute)
  end
end
