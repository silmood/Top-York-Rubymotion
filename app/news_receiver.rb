class NewsReceiver < Android::Content::BroadcastReceiver
  def onReceive(context, intent)
    action = intent.getAction

    case action
      when MainActivity::LOAD_NEWS_COMPLETE_ACTION
        news = intent.getSerializableExtra LoadNewsOperation::NEWS
        puts "Loaded todo list: #{news}"
    end
  end
end