mongoose = require("mongoose")

Schema = mongoose.Schema

userSchema = new Schema(
  id_str                  : String
  screen_name             : String
  token                   : String
  tokenSecret             : String
  description             : String
  url                     : String
  profile_image_url       : String
  profile_image_url_https : String
)

module.exports = mongoose.model "User", userSchema