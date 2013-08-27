// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require) {
    var $, Backbone, Marionette, Tweets, TweetsView, app, io, tweets, tweetsView, viewOptions, _;
    $ = require('jquery');
    Backbone = require('backbone');
    _ = require('lodash');
    io = require('io');
    Marionette = require('marionette');
    Tweets = require('tweets');
    TweetsView = require('tweetsView');
    window.app = app = new Marionette.Application();
    tweets = new Tweets();
    viewOptions = {
      collection: tweets
    };
    tweetsView = new TweetsView(viewOptions);
    app.addRegions({
      main: '.tweets-container'
    });
    app.addInitializer(function() {
      return app.main.show(tweetsView);
    });
    return app.on('initialize:after', function() {
      var socket;
      socket = io.connect();
      socket.on("connect", function() {
        return console.log("Connected!");
      });
      socket.on("message", function(data) {
        return tweets.add(data);
      });
      $("form").on("submit", function(e) {
        e.preventDefault();
        console.log("Changing track", $(".search-query").data('userid'), $(".search-query").val());
        return socket.emit("change_track", {
          track: $(".search-query").val(),
          userId: $(".search-query").data('userid')
        });
      });
      return $(".pause").on('click', function(e) {
        e.preventDefault();
        if ($(this).hasClass('run')) {
          socket.emit('pause_stream');
          $(this).html('Resume');
        } else {
          socket.emit('resume_stream');
          $(this).html('Pause');
        }
        return $(this).toggleClass('run');
      });
    });
  });

}).call(this);
