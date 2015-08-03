class ChatChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "chat_activity"
  end

  def unsubscribed
    stop_all_streams
  end

  def message(data)
    message = nil

    ActiveRecord::Base.connection_pool.with_connection do |conn|
      message = Message.create(text: data['text'], user: self.connection.current_user)
    end

    ActionCable.server.broadcast "chat_activity", render_message_html(message)
  end

  private

  def render_message_html(message)
    ChatRoomController.render(
      partial: 'chat_room/message',
      locals: { message: message }
    )
  end
end
