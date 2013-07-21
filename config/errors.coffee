module.exports = (app) ->
  NotFound = (msg) ->
    @name = "NotFound"
    Error.call this, msg
    Error.captureStackTrace this, arguments_.callee
  NotFound::__proto__ = Error::
  
  #  Catch all
  
  # app.all('*', function notFound(req, res, next) {
  #    throw new NotFound;
  # });
  
  # Load 404 page
  
  # app.use(function(err, req, res, next){
  #   res.status(404);
  #   if (err instanceof NotFound) {
  #       res.render('home/404');
  #   } else {
  #       next(err);
  #   }
  # });
  
  # Load 500 page
  
  app.use (err, req, res)->
    console.log err
    res.status 500
    res.render 'home/500', {
      error: err
    }
    
  app