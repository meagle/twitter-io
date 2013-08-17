mongoose = require("mongoose")

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

userSchema = new Schema(
  id_str          : ObjectId
  token           : String
  tokenSecret       : String
  screen_name         : String
  description         : String
  url             : String
  profile_image_url     : String
  profile_image_url_https : String
  
)
module.exports = mongoose.model("User", userSchema)