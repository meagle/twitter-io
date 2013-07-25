var path = require('path')

try {
  require.paths = require.paths.unshift(__dirname + '/../node_modules');
} catch(e) {
  process.env.NODE_PATH = path.join(__dirname, '/../node_modules') + ':' + process.env.NODE_PATH
}

// require('./lib/exceptions')

if(!process.env.NODE_ENV) process.env.NODE_ENV="development"

var app = require('./config/app')();

