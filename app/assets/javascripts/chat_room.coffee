#= require cable
#= require_self

@App = {}
App.cable = Cable.createConsumer "ws://localhost:28080"

App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called once the subscription has been successfully completed

  sendMessage: (text) ->
    @perform 'message', text: text

  received: (data) ->
    message = "<div class='message"
    message += " my-message" if data.is_from_current_user
    message += "'>" + data.name + ": " + data.text
    message += "</div>"
    $('.chat ').append message

$(document).on 'submit', '#chat_form', ->
  text_field = $('#chat_form > input[name=message_text]')
  text = text_field.val()
  text_field.val('')

  App.chat.sendMessage text
  false
