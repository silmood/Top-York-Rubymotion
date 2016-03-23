class NewsApi

  SCHEME = "http"
  BASE_URL = "api.nytimes.com"
  SVC = "svc"
  VERSION = "v1"
  FORMAT = "json"
  FETCH_TOP_STORIES = "topstories"
  SECTION = "home"
  API_KEY = "api-key"
  PRIVATE_KEY = "9a0a5f5c65703adf67e0537a494d2b14:15:74435779"

  def client
    Com::Squareup::Okhttp::OkHttpClient.new
  end

  def url_builder
    builder = Com::Squareup::Okhttp::HttpUrl::Builder.new
    builder.scheme SCHEME
    builder.host BASE_URL
    builder.addPathSegment SVC
    yield builder
    builder.addQueryParameter API_KEY, PRIVATE_KEY
    builder.build
  end

  def request_builder
    builder = Com::Squareup::Okhttp::Request::Builder.new
    builder.header "Content-Type", "application/json"
    builder.header "Accept", "application/json"
    yield builder
    builder.build
  end

  def form_body_builder
    builder = Com::Squareup::Okhttp::FormEncodingBuilder.new
    yield builder
    builder.build
  end

  def execute_request(request)
    client.newCall(request).execute
  end

  def parse_array_response(response)
    stream = response.body.charStream
    deserializeNewsArray stream
  end

  def parse_object_response(response)
    stream = response.body.charStream
    gson = Com::Google::Gson::Gson.new
    gson.fromJson(stream, Java::Util::HashMap)
  end

  def get_top_news
    url = get_fetch_top_stories_url
    puts url.toString

    request = request_builder do |builder|
      builder.url url
      builder.get
    end

    response = execute_request request
    parse_array_response response
  end

  def get_fetch_top_stories_url
    url = url_builder do |builder|
      builder.addPathSegment FETCH_TOP_STORIES
      builder.addPathSegment VERSION
      builder.addPathSegment SECTION + "." + FORMAT
    end
  end

  #Return Hash using Moran to parse response
  def deserializeNewsArray(stream)
    scanner = Java::Util::Scanner.new(stream)
    scanner.useDelimiter "\\A"
    response_string = scanner.next
    Moran.parse(response_string)
  end

end