express = require("express")
stylus = require("stylus")
nib = require("nib")
mongoose = require("mongoose")

# module.exports = (app) ->
app = module.exports = express()

console.log 'Adding Configurations...'

compile = (str, path) ->
  stylus(str).set("filename", path).include nib.path

# app.configure ->
app.use express.logger("\u001b[90m:method\u001b[0m \u001b[36m:url\u001b[0m \u001b[90m:response-time ms\u001b[0m")
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.bodyParser()
app.use express.errorHandler
  dumpException: true
  showStack: true

app.use express.cookieSession(secret: "doyouwannaknowmysecret?")
app.use app.router

# app.configure ->
# @use(express.static(__dirname + "/../public")).set("view engine", "jade").set("views", __dirname + "/../app/views").use stylus.middleware(
app.use(express.static(__dirname + "/../public"))
app.set("view engine", "jade")
console.log "view engine is:", app.get('view engine')
app.set("views", __dirname + "/../app/views")
app.use stylus.middleware(
  src: __dirname + "/../public"
  compile: compile
)

# app