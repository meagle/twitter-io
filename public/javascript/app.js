// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require) {
    var $, Backbone, Marionette, io, socket, _;
    $ = require('jquery');
    Backbone = require('backbone');
    _ = require('lodash');
    io = require('io');
    Marionette = require('marionette');
    socket = io.connect();
    socket.on("connect", function() {
      return console.log("connected");
    });
    socket.on("message", function(data) {
      var div;
      div = $("<div></div>").html("<img src='" + data.user.profile_image_url + "'</img><span style='font-weight:bold'>" + data.user.screen_name + "</span><span>" + data.text + "</span>").addClass("word");
      return $(".tweets").prepend(div);
    });
    return $("form").on("submit", function(e) {
      e.preventDefault();
      console.log("Changing track", $("form > input").val());
      socket.emit("change_track", {
        track: $("form > input").val()
      });
      socket.socket.disconnect();
      return socket.socket.reconnect();
    });
  });

}).call(this);
