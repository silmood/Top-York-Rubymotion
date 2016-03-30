class MainActivity < Android::Support::V7::App::AppCompatActivity
  LOAD_NEWS_COMPLETE_ACTION = "load_news_completed"

  def onCreate(savedInstanceState)
    super

    setContentView R::Layout::Main_layout

    @progressBar = findViewById R::Id::Progress
    @newsList = findViewById R::Id::News_list

    @newsReceiver = createReceiver
  end

  def onStart
    super
    loadNews_with_flow
  end

  def createReceiver()
    receiver = NewsReceiver.new self

    #Create intent filters for each action
    loadIntentFilter = Android::Content::IntentFilter.new(LOAD_NEWS_COMPLETE_ACTION)

    #Register receiver
    Android::Support::V4::Content::LocalBroadcastManager.
        getInstance(self).registerReceiver(receiver, loadIntentFilter)
  end

  def loadNews
    setProgressVisibility(true)
    LoadNewsOperation.new(getApplicationContext).execute
  end

  def loadNews_with_flow
    setProgressVisibility(true)
    NewsFetcher.fetch_news do |response|
      news = response['results']
      displayNews news
    end
  end

  def displayNews(news)
    setProgressVisibility(false)
    @newsList.setAdapter(createAdapter(news))
  end

  def setProgressVisibility(visible)
    @progressBar.setVisibility(visible ? Android::View::View::VISIBLE : Android::View::View::INVISIBLE)
  end

  def createAdapter(news)
    NewsAdapter.new(self, 0, news)
  end

  class NewsReceiver < Android::Content::BroadcastReceiver

    def initialize(parent)
      @parent = parent
    end

    def onReceive(context, intent)
      action = intent.getAction

      case action
        when MainActivity::LOAD_NEWS_COMPLETE_ACTION
          news = intent.getSerializableExtra LoadNewsOperation::NEWS
          @parent.displayNews news["results"]
        else
          # type code here
      end
    end
  end

end
