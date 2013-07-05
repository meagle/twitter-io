$(document).ready(function(){
    var socket = io.connect();

    socket.on('connect', function(){
        console.log('connected');
    });

    socket.on('message', function(data) { 
    var div = $("<div></div>")
        .html("<span style='font-weight:bold'>" + data.user.screen_name + "</span><span>" +  data.text + "</span>")
        .addClass('word');

    $(".tweets").prepend(div);
    });

    //- TODO: replace this crap when switching to Backbone

    $('form').on('submit', function(e){
        e.preventDefault();
        console.log('Changing track', $('form > input').val());
        socket.emit('change_track', {track: $('form > input').val()});
        socket.socket.disconnect();
        socket.socket.reconnect();

    })

});
