define (require)->
  $           = require 'jquery'
  Backbone    = require 'backbone'
  _           = require 'lodash'
  io          = require 'io'
  Marionette  = require 'marionette'

    
  socket = io.connect()
  socket.on "connect", ->
    console.log "connected"

  socket.on "message", (data) ->
    div = $("<div></div>").html("<img src='" + data.user.profile_image_url + "'</img><span style='font-weight:bold'>" + data.user.screen_name + "</span><span>" + data.text + "</span>").addClass("word")
    $(".tweets").prepend div


  #- TODO: replace this crap when switching to Backbone
  $("form").on "submit", (e) ->
    e.preventDefault()
    console.log "Changing track", $("form > input").val()
    socket.emit "change_track",
      track: $("form > input").val()

    socket.socket.disconnect()
    socket.socket.reconnect()
