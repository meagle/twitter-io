require.config
  waitSeconds: 60
  onError: (requireType, requireModules) ->
    if requireType is 'timeout'
      alert 'Twitter-io Module: Your connection seems to be very slow at the moment.\nPlease try again later.'
  paths:
    jquery                  : "/twitterio/components/jquery/jquery"
    lodash                  : "/twitterio/components/lodash/lodash"
    backbone                : "/twitterio/components/backbone/backbone"
    marionette              : "/twitterio/components/backbone.marionette/lib/backbone.marionette"
    bootstrap               : "/twitterio/components/bootstrap/js/bootstrap"
    io                      : "/socket.io/socket.io"

    # twitterio               : "twitterio"
    # tweet                   : "models/Tweet"

    # tweets                  : "collections/Tweets"

    # alertModalView          : "views/AlertModalView"

  shim:
    jquery:
      exports: '$'
    lodash:
      exports: '_'
    backbone:
      deps: [ 'lodash', 'jquery' ]
      exports: "Backbone"
    bootstrap:
      exports: 'Bootstrap'
      deps: ['jquery']
    marionette:
      exports: 'Marionette'
      deps: ['bootstrap']
    io:
      exports: 'io'

define (require)->
  $           = require 'jquery'
  Backbone    = require 'backbone'
  _           = require 'lodash'
  Marionette  = require 'marionette'
  app         = require 'app'
  
  $ ->
    app.start()

