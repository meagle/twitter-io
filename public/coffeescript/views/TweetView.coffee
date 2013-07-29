define (require)->
  $           = require 'jquery'
  _           = require 'lodash'
  Backbone    = require 'backbone'
  Marionette  = require 'marionette'

  class TweetView extends Backbone.Marionette.ItemView
    tagName:    'li'
    className:  'tweet clearfix'
    template: 	'#tweetTpl'
