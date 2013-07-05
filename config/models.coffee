mongoose = require("mongoose")
module.exports = ->
  mongoose.model "Tweet", require("../app/models/tweet")