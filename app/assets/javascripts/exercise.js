$(document).on("turbolinks:load", function(){

  var body = $('body');

  if (body.hasClass('exercises') && body.hasClass('index'))
    {
      $('.navbar').css("background-color", "#D8D8D8");
      $('.navbar-brand').css("color", "#000");
      $('.navbar-default .navbar-nav > li > a').css("color", "#000");
      $('.navbar-default .navbar-brand').css("border", "1px solid #000");
    }

  $(".datepicker").datepicker({format: 'yyyy/mm/dd'});
});
