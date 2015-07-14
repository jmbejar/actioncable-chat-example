#= require cable
#= require_self

@App = {}

currentUserId = ->
  $('.chat').data('current-user-id')

highlightMyMessages = ->
  $('.chat > .message').each ->
    if $(this).data('user-id') == currentUserId()
      $(this).addClass('my-message')

$(document).on 'ready page:load', ->
  if $('.chat').length > 0
    App.cable = Cable.createConsumer "ws://localhost:28080"

    App.chat = App.cable.subscriptions.create "ChatChannel",
      connected: ->
        # Called once the subscription has been successfully completed

      sendMessage: (text) ->
        @perform 'message', text: text

      received: (message) ->
        $('.chat ').append message
        highlightMyMessages()

    highlightMyMessages()


$(document).on 'submit', '#chat_form', ->
  text_field = $('#chat_form > input[name=message_text]')
  text = text_field.val()
  text_field.val('')

  App.chat.sendMessage text
  false
