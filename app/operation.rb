class Operation
  def initialize(context)
    @context = context
  end

  def new_intent(action)
    Android::Content::Intent.new(action)
  end

  def broadcast_intent(intent)
    broadcastManager = 
      Android::Support::V4::Content::LocalBroadcastManager.getInstance(@context)
    broadcastManager.sendBroadcast intent
  end

  def execute
    Android::Os::AsyncTask.execute self
  end

  def add_serializable_extras(intent, extras)
    extras.each do |key, value|
        addSerializableExtra intent, key, value
    end
  end
end