//include stylesheet if not included
(function(s){
  var link = document.createElement( "link" );
  link.href = s;
  link.type = "text/css";
  link.rel = "stylesheet";
  link.media = "screen,print";
  document.getElementsByTagName( "head" )[0].appendChild( link );
})("myscript.css")

document.addEventListener("DOMContentLoaded", function(){



//include shadow for cards if not included
document.querySelectorAll('.jarviswidget').forEach(function(e) {
   //e.className = e.className + " shadow"
});


})
