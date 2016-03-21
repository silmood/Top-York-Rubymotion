class NewsApi

  BASE_URL = "http://api.nytimes.com/svc/"
  VERSION = "/v1"
  FORMAT = "json"
  SECTION = "home"
  FETCH_TOP_STORIES = BASE_URL + "topstories" +
                VERSION + "/" + SECTION + "." + FORMAT;

  def client
    Com::Squareup::Okhttp::OkHttpClient.new
  end

  def request_builder
    builder = Com::Squareup::Okhttp::Request::Builder.new
    builder.header "Content-Type", "application/json"
    builder.header "Accept","application/json"
    yield builder
    builder.build
  end

  def form_body_builder
    builder = Com::Squareup::Okhttp::FormEncodingBuilder.new
    yield builder
    builder.build
  end

  def execute_request(request)
    client.newCall(request).execute()
  end

  def parse_array_response(response)
    stream = response.body.charStream
    puts stream
    #deserializeTodoArray stream
  end

  def parse_object_response(response)
    stream = response.body.charStream
    gson = Com::Google::Gson::Gson.new
    gson.fromJson(stream, Java::Util::HashMap)
  end

  def get_top_news
    request = request_builder do |builder|
      builder.url FETCH_TOP_STORIES
      builder.get
    end

    response = execute_request request
    parse_array_response response
  end
end