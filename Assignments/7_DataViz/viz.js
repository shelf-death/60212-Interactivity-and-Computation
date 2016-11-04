/************************************
*    HIDDEN INITIALIZATION BLOCK    *
************************************/

// Select the DOM element
var parent = d3.select("#visualization");

// Set up the margins
var bbox   = parent.node().getBoundingClientRect();
var margin = {top: 50, right: 50, bottom: 50, left: 50};
var width  = +bbox.width - margin.left - margin.right;
var height = +bbox.height - margin.top - margin.bottom;

// Define svg as a group within the base SVG.
var svg = parent.select("svg").append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    console.log("spaghetti");

/************************************
*  END HIDDEN INITIALIZATION BLOCK  *
************************************/

var data = null;

var circle = svg.append("circle")
    .attr("cy", 100)
    .attr("cx", 100)
    .attr("r", 50);

