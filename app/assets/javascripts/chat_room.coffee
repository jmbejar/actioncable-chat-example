#= require cable
#= require_self

@App = {}
App.cable = Cable.createConsumer "ws://localhost:28080"
