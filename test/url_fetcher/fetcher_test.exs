defmodule UrlFetcher.FetcherTest do
  use ExUnit.Case, async: true

  alias UrlFetcher.{Fetcher, Http.Response}

  import Mox

  setup :verify_on_exit!

  describe "fetch/1" do
    test "empty body must return no assets or links" do
      expect(UrlFetcher.Http.ClientMock, :get, fn _ ->
        {:ok, %Response{status_code: 200, body: ""}}
      end)

      assert {:ok, %{assets: [], links: []}} = Fetcher.fetch("www.foo.bar")
    end

    test "document as only one image and no links" do
      expect(UrlFetcher.Http.ClientMock, :get, fn _ ->
        {:ok, %Response{status_code: 200, body: "<img src='http://foo'/>"}}
      end)

      assert {:ok, %{assets: ["http://foo"], links: []}} = Fetcher.fetch("www.foo.bar")
    end

    test "document has one link and no image" do
      expect(UrlFetcher.Http.ClientMock, :get, fn _ ->
        {:ok, %Response{status_code: 200, body: "<a href='http://bah'/>"}}
      end)

      assert {:ok, %{assets: [], links: ["http://bah"]}} = Fetcher.fetch("www.foo.bar")
    end

    test "HTTP error reason must be returned on errors" do
      expect(UrlFetcher.Http.ClientMock, :get, fn _ ->
        {:error, :nxdomain}
      end)

      assert {:error, :nxdomain} = Fetcher.fetch("www.blah.com")
    end
  end
end
