class NewsReceiver < Android::Content::BroadcastReceiver
  def onReceive(context, intent)
    action = intent.getAction

    case action
      when LOAD_TOP_NEWS
        news = intent.getSerializableExtra LoadTopNewsOperation::NEWS
        puts "Loaded todo list: #{news}"
    end
  end
end