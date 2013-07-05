ev = require("../app/hooks/event")
module.exports = (app) ->
  app.on "event:send:tweets", ev.send_tweets