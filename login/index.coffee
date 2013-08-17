passport    = require("passport")
express     = require("express")
stylus      = require("stylus")
nib         = require("nib")
# mongoose    = require("mongoose")
keys        = require("../config/keys")()

module.exports = ->
  app = express()

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
  app.set("views", __dirname + "/views")

  app.use(express.static(__dirname + "/../public"))
  app.use(passport.initialize());
  app.use(passport.session()); 
  app.use(app.router);

  passport.serializeUser (user, done) ->
    console.log 'passport.serializeUser', user
    done null, user.id

  passport.deserializeUser (id, done) ->
    # User.findOne id, (err, user) ->
      # done err, user
    console.log 'passport.deserializeUser id: ', id
    done null, id



  TwitterStrategy = require("passport-twitter").Strategy
  passport.use new TwitterStrategy(
    consumerKey: keys.consumer_key
    consumerSecret: keys.consumer_secret
    callbackURL: "http://localhost:3000/login/auth/twitter/callback"
  , (token, tokenSecret, profile, done) ->
    console.log 'token: ', token
    console.log 'tokenSecret: ', tokenSecret
    console.log 'profile: ', profile
    done(null, profile);
  )


  # Redirect the user to Twitter for authentication.  When complete, Twitter
  # will redirect the user back to the application at
  #   /auth/twitter/callback
  app.get "/auth/twitter", passport.authenticate("twitter")

  # Twitter will redirect the user to this URL after approval.  Finish the
  # authentication process by attempting to obtain an access token.  If
  # access was granted, the user will be logged in.  Otherwise,
  # authentication has failed.
  app.get "/auth/twitter/callback", passport.authenticate("twitter",
    successRedirect: "/twitterio"
    failureRedirect: "/login"
  )

  app.get '/', (req, res, next)->
    res.render "index", {}

