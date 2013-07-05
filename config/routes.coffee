module.exports = (app, socket) ->
  home = require("../app/controllers/home_controller")(app, socket)
  app.get "/", home.index # *Root
  app.get "/about", home.load.bind(null, "home/about")