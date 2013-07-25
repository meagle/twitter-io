Schema = require("mongoose").Schema
ObjectId = Schema.ObjectId
Tweet = module.exports = new Schema(
  user_name:
    type: String
    required: true

  profile_image_url:
    type: String
    required: true 

  text:
    type: String
    required: true

  id_str:
    type: String
    required: true

  retweeted:
    type: Boolean
    default: false

  created_at:
    type: Date
)
Tweet.statics.getLatestTweets = (callback) ->
  @find().sort("_id", "descending").limit(15).find {}, callback

Tweet.statics.findByUser = (user_name, callback) ->
  @findOne
    user_name: user_name
  , callback

Tweet.pre "save", (next) ->
  console.log "Saving..."
  next()

Tweet.pre "remove", (next) ->
  console.log "removing..."
  next()

Tweet.pre "init", (next) ->
  console.log "initializing..."
  next()
