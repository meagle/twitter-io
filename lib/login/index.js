// Generated by CoffeeScript 1.6.3
(function() {
  var User, express, keys, mongoose, nib, passport, stylus;

  passport = require("passport");

  express = require("express");

  stylus = require("stylus");

  nib = require("nib");

  mongoose = require("mongoose");

  keys = require("../config/keys");

  User = require("../models/user");

  module.exports = function() {
    var TwitterStrategy, app;
    app = express();
    app.use(express.cookieSession({
      secret: "doyouwannaknowmysecret?"
    }));
    app.set("views", __dirname + "/views");
    app.use(express["static"](__dirname + "/../../public"));
    app.use(passport.initialize());
    app.use(passport.session());
    app.use(app.router);
    passport.serializeUser(function(user, done) {
      console.log('passport.serializeUser', user.id_str);
      return done(null, user.id_str);
    });
    passport.deserializeUser(function(id, done) {
      return User.findOne(id, function(err, user) {
        console.log('passport.deserializeUser user: ', user);
        return done(err, user);
      });
    });
    TwitterStrategy = require("passport-twitter").Strategy;
    passport.use(new TwitterStrategy({
      consumerKey: keys.consumer_key,
      consumerSecret: keys.consumer_secret,
      callbackURL: "http://localhost:3000/login/auth/twitter/callback"
    }, function(token, tokenSecret, profile, done) {
      profile = profile._json;
      profile.token = token;
      profile.tokenSecret = tokenSecret;
      return User.findOne({
        id_str: profile.id_str
      }, function(err, user) {
        if (err) {
          return done(err);
        }
        if (!user) {
          return new User(profile).save(function(err, user) {
            if (err) {
              return done(err);
            }
            return done(null, user);
          });
        } else {
          return done(null, user);
        }
      });
    }));
    app.get("/auth/twitter", passport.authenticate("twitter"));
    app.get("/auth/twitter/callback", passport.authenticate("twitter", {
      successRedirect: "/twitterio",
      failureRedirect: "/login"
    }));
    return app.get('/', function(req, res, next) {
      return res.render("index", {});
    });
  };

}).call(this);