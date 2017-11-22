window.mainNewsEntryNamespace ?= {}

window.mainNewsEntryNamespace.registrerChannel = ->
  console.log "Register MainNewsEntryChannel channel"

  App.main_news_entry = App.cable.subscriptions.create "MainNewsEntryChannel",
    connected: ->
      console.log "Subscrubed for MainNewsEntryChannel"

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log "Received data: "
      console.log data.content

      news = data.content

      unless news.blank?
        $('.current-main-news-entry #title').text(news.title)
        $('.current-main-news-entry #annotation').text(news.annotation)
        $('.current-main-news-entry #published_at').text(news.published_at)