class ChatRoomController < ApplicationController
  before_action :authenticate_user!

  NUMBER_OF_MESSAGES = 15

  def index
    @messages = Message.last(NUMBER_OF_MESSAGES)
  end
end
