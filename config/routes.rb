Rails.application.routes.draw do
  get 'chat_room/index'

  devise_for :users

  root 'chat_room#index'
end
