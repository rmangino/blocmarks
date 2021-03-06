// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

// This is for the blocmetrics app. Every time we click on a page we send that event to the
// api portion of the blocmetrics app.
$( document ).ready(function() {
  $( window ).click( function() {
      console.log( "You clicked!!!!!!" );
      blocmetrics.report("click");
  });
});

var blocmetrics = {};

blocmetrics.report = function(eventName) {
  var event = { name: eventName };
  var request = new XMLHttpRequest();

  //request.open("POST", "https://reeds-blocmetrics.herokuapp.com/api/events", true);
  request.open("POST", "https://localhost/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');

  request.send(JSON.stringify(event));
}