ExUnit.start()

# Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)
Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)
Mox.defmock(UrlFetcher.Http.ClientMock, for: UrlFetcher.Http.Adapter)
