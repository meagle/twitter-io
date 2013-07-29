define (require)->
  Backbone    = require 'backbone'
  _           = require 'lodash'
  io          = require 'io'
  Marionette  = require 'marionette'

  class Tweet extends Backbone.Model
