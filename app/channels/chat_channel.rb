class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_activity"
  end

  def unsubscribed
  end

  def message(data)
    message = Message.create(text: data['text'], user: self.connection.current_user)

    broadcast_data = {
      name: message.user.name,
      text: message.text,
      is_from_current_user: self.connection.current_user == message.user
    }

    ActionCable.server.broadcast "chat_activity", broadcast_data
  rescue Exception => ex
    p ex
    byebug
  end
end
