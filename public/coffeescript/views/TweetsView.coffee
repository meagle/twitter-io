define (require)->
  $           = require 'jquery'
  _           = require 'lodash'
  Backbone    = require 'backbone'
  Marionette  = require 'marionette'
  TweetView   = require 'tweetView'

  class TweetsView extends Backbone.Marionette.CollectionView
    tagName:    'ul'
    className:  'tweets'
    itemView:   TweetView
    # emptyView:  NoTweetsView 

    appendHtml: (collectionView, itemView, index)->
      collectionView.$el.prepend itemView.el