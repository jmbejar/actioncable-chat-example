Rails.application.routes.draw do
  get 'chat_room/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'chat_room#index'
end
