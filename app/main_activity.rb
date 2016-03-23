class MainActivity < Android::Support::V7::App::AppCompatActivity
  LOAD_NEWS_COMPLETE_ACTION = "load_news_completed"

  def onCreate(savedInstanceState)
    super
    @newsReceiver = NewsReceiver.new self
    registerReceiver(@newsReceiver)
  end

  def registerReceiver(receiver)
    #Create intent filters for each action
    loadIntentFilter = Android::Content::IntentFilter.new(LOAD_NEWS_COMPLETE_ACTION)

    #Register receiver
    Android::Support::V4::Content::LocalBroadcastManager.
        getInstance(self).registerReceiver(receiver, loadIntentFilter)
  end

  def loadNews
    LoadNewsOperation.new(getApplicationContext).execute
  end

  def displayNews(news)
    puts "#{news}"
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
          @parent.displayNews news
        else
          # type code here
      end
    end
  end

end
