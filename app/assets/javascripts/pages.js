$(document).on("turbolinks:load", function(){

  var body = $('body');

  if (body.hasClass('sessions') && body.hasClass('new'))
    {
      $('.navbar').css("background-color", "#D8D8D8");
      $('.navbar-brand').css("color", "#000");
      $('.navbar-default .navbar-nav > li > a').css("color", "#000");
      $('.navbar-default .navbar-brand').css("border", "1px solid #000");
    }
});