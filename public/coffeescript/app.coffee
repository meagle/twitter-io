define (require)->
  $           = require 'jquery'
  Backbone    = require 'backbone'
  _           = require 'lodash'
  io          = require 'io'
  Marionette  = require 'marionette'
  Tweets      = require 'tweets'
  TweetsView  = require 'tweetsView'

  window.app = app = new Marionette.Application()

  tweets = new Tweets()

  viewOptions = 
    collection: tweets

  # header = new Header viewOptions
  tweetsView = new TweetsView viewOptions
  # footer = new Footer viewOptions

  app.addRegions
    # TODO: implement these views
    # header: '#header'
    # footer: '#footer'
    main:   '.tweets-container'

  app.addInitializer ->
    # app.header.show header
    # app.footer.show footer
    app.main.show tweetsView

  #Consider adding a controller for this stuff
  # app.listenTo tweets, 'all' ->
    # TODO: do some work to reflect tweets

  # app.vent.on 'tweets:clear' ->
    # TODO: remove all tweets

  app.on 'initialize:after', ->

    socket = io.connect()
    socket.on "connect", ->
      console.log "Connected!"

    socket.on "message", (data) ->
      tweets.add data


    #- TODO: move this crap to a view 
    $("form").on "submit", (e) ->
      e.preventDefault()
      console.log "Changing track", $("form > input").val()
      socket.emit "change_track",
        track: $("form > input").val()

      socket.socket.disconnect()
      socket.socket.reconnect()
