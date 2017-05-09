// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

    $(document).ready(function() {  
        //var audioSection = $('section#audio');  
        $('a.html5').click(function() {  
      		
      		var audioSection = $('section#audio');
      		
            var audio = $('<audio>', {  
                 controls : 'controls',
                 autoplay : 'autoplay',
                 text : 'Seu navegador não suporta elemento de audio.'
            });  
      
            var url = $(this).attr('href');  
            $('<source>').attr('src', url).appendTo(audio);  
            audioSection.html(audio);  
            return false;  
        });  
    });
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-26033102-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
