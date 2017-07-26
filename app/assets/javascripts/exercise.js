$(document).on("turbolinks:load", function(){

  var body = $('body');

  if (body.hasClass('exercises') && body.hasClass('index')) {
    $('.navbar').css("background-color", "#D8D8D8");
    $('.navbar-brand').css("color", "#000");
    $('.navbar-default .navbar-nav > li > a').css("color", "#000");
    $('.navbar-default .navbar-brand').css("border", "1px solid #000");
    // d3 chart
    drawChart();
  }

  else {
    $('.navbar').css("background-color", "#D8D8D8");
    $('.navbar-brand').css("color", "#000");
    $('.navbar-default .navbar-nav > li > a').css("color", "#000");
    $('.navbar-default .navbar-brand').css("border", "1px solid #000");
    $(".datepicker").datepicker({format: 'yyyy/mm/dd'});
  }
});

var drawChart = function() {
var margin = { top: 100, right: 20, bottom: 100, left: 50 },
  width  = 600 - margin.left - margin.right,
  height = 450 - margin.top - margin.bottom;
var JSONData = $("#chart").data("workouts");

if (!JSONData) {
  return;
}

var data = JSONData.slice()

var parseTime = d3.timeParse("%Y-%m-%d");

var workoutFn = function(d) { return d.duration }
var dateFn = function(d) { return parseTime(d.activity_date) }

var x = d3.scaleTime()
  .range([0, width])
  .domain([Date.now() - ( 7 * 24 * 60 * 60 * 1000), Date.now()])

var y = d3.scaleLinear()
  .range([height, 0])
  .domain([0, d3.max(data, workoutFn)])

var workout_line = d3.line()
  .x(function(d) { return x(d.activity_date); })
  .y(function(d) { return y(d.duration);  });

data.forEach(function(d) {
  d.activity_date = parseTime(d.activity_date);
  d.duration = +d.duration;
});

var svg = d3.select("#chart").append("svg")
.attr("width", width + margin.left + margin.right)
.attr("height", height + margin.top + margin.bottom)
.append("g")
  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  svg.append("path")
    .attr("class", "line")
    .attr("d", workout_line(data));

svg.append("g")
 .attr("class", "x axis")
 .attr("transform", "translate(0," + height + ")")
 .call(d3.axisBottom(x)
    .ticks(d3.timeDay.every(1))
    .tickFormat(d3.timeFormat('%Y-%m-%d'))
  )
  .selectAll("text")
  .style("text-anchor", "end")
  .attr("dx", "-.8em")
  .attr("dy", ".15em")
  .attr("transform", "rotate(-60)");

 // x axis label
 svg.append("text")
  .attr("x", width / 2)
  .attr("y", height + margin.top - 15)
  .style("text-anchor", "middle")
  .text("Date of workout")

 svg.append("g")
  .attr("class", "y axis")
  .call(d3.axisLeft(y).ticks(4));

// y axis label
svg.append("text")
 .attr("transform", "rotate(-90)")
 .attr("y", 0 - margin.left)
 .attr("x", 0 - (height / 2))
 .attr("dy", "1em")
 .style("text-anchor", "middle")
 .text("Workout duration (min)")

 // Chart title
 svg.append("text")
  .attr("x", (width / 2))
  .attr("y", 0 - (margin.top / 2))
  .style("text-anchor", "middle")
  .style("font-size", "18px")
  .style("text-decoration", "underline")
  .text("Workout duration vs Workout date")
};

