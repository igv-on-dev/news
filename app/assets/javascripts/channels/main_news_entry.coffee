App.main_news_entry = App.cable.subscriptions.create "MainNewsEntryChannel",
  connected: ->
    console.log "Subscrubed for MainNewsEntryChannel"

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log "Received data: " + data.content
