module.exports = (app) ->
  port = process.env.PORT or 3000
  app.configure "development", ->
    @set("host", "localhost").set("port", port).set "ENV", "development"

  app.configure "production", ->
    @set("port", port).set "ENV", "production"

  app