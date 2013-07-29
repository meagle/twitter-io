define (require)->
  Backbone    = require 'backbone'
  _           = require 'lodash'
  io          = require 'io'
  Marionette  = require 'marionette'
  Tweet 	  = require 'tweet'

  class Tweets extends Backbone.Collection
  	model: Tweet