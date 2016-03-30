class NewsFetcher
  def self.fetch_news(&block)
    Net.get("http://api.nytimes.com/svc/topstories/v1/home.json?api-key=9a0a5f5c65703adf67e0537a494d2b14:15:74435779") do |response|
      response_hash = Moran.parse(response.body)
      block.call(response_hash || []) if block
    end
  end
end