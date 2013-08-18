passport    = require "passport"
express     = require "express"
stylus      = require "stylus"
nib         = require "nib"
mongoose    = require "mongoose"
keys        = require "../config/keys"
User        = require "../models/user"

module.exports = ->
  app = express()

  app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
  app.set("views", __dirname + "/views")

  app.use(express.static(__dirname + "/../../public"))
  app.use(passport.initialize());
  app.use(passport.session()); 
  app.use(app.router);

  passport.serializeUser (user, done) ->
    console.log 'passport.serializeUser', user.id_str
    done null, user.id_str

  passport.deserializeUser (id, done) ->
    User.findOne id, (err, user) ->
      # done err, user
      console.log 'passport.deserializeUser user: ', user
      done err, user


  TwitterStrategy = require("passport-twitter").Strategy
  passport.use new TwitterStrategy
    consumerKey: keys.consumer_key
    consumerSecret: keys.consumer_secret
    #TODO: derive the domain and port
    callbackURL: "http://localhost:3000/login/auth/twitter/callback"
  , (token, tokenSecret, profile, done) ->

    profile = profile._json
    profile.token = token
    profile.tokenSecret = tokenSecret
    User.findOne id_str: profile.id_str, (err, user)->

      return done(err) if err

      unless user
        new User(profile).save (err, user)->
          return done(err) if err
          done null, user
      else
        done null, user
  


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

