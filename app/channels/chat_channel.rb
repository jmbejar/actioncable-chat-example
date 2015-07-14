class ChatChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "chat_activity"
  end

  def unsubscribed
    stop_all_streams
  end

  def message(data)
    message = Message.create(text: data['text'], user: self.connection.current_user)

    broadcast_data = {
      name: message.user.name,
      text: message.text,
      is_from_current_user: self.connection.current_user == message.user
    }

    ActionCable.server.broadcast "chat_activity", broadcast_data
  end
end
