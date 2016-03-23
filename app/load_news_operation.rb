class LoadNewsOperation < Operation
  NEWS = "news"

  def run
    api = NewsApi.new
    news = api.get_top_news
    
    intent = new_intent MainActivity::LOAD_NEWS_COMPLETE_ACTION
    add_serializable_extras intent, NEWS => news
    broadcast_intent intent
  end
end
