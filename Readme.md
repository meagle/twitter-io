# twitter-io

This is a simple app that uses the streaming API from Twitter via nTwitter with Node.js, Jade, Socket.io, Backbone.js, Marionette.js, require.js, Twitter Bootstrap, Stylus, etc


### Twitter Keys

If you are going to try this out for yourself then you will need to get a developer Twitter account so you can add your consumer and access token keys.  You can generate these on Twitter's developer site here: [dev.twitter.com](https://dev.twitter.com/) and create a new application

### NPM Modules

After you clone this repo you will need to run

    npm install

to pickup my Node modules

### Grunt 

If you want to extend this project then install [Grunt](http://gruntjs.com/) to automate CoffeeScript compilation.  Just run

    grunt watch

from the root of this project

### Starting Node Server

I use [Supervisor](https://github.com/isaacs/node-supervisor) to watch for changes when I am developing Node apps.  Then run

    supervisor index

from the root of this project.  Or just run:

    node index

### Browser

Point your browser at http://localhost:3000/twitterio and enter tracks as strings separated by commas to start streaming Tweets.  


