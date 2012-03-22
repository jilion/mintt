//= require prototype
//= require effects
//= require controls
//= require rails

document.observe("dom:loaded", function() {
  // If Windows Disable Typekit
  if ((navigator.userAgent.indexOf("Windows")!=-1)) $(document.body).addClassName('win');
  
  $$('tr.message').each(function(tr){
    tr.observe('click', function(e){
      if (!e.element().hasClassName("link") && !e.element().hasClassName("button")) {
        window.location = tr.down('input[type=hidden]').value;
      }
    });
  });
  
  if (Prototype.Browser.IE) {
    var settings = {
      tl: { radius: 21 },
      tr: { radius: 21 },
      bl: { radius: 21 },
      br: { radius: 21 },
      antiAlias: true
    };
    
    $$('ul#menu li a').each(function(a){
      if (!a.up("li").hasClassName("home")) {
        a.addClassName("curvyRedraw");
        curvyCorners(settings, a);
      }
    });
  }

  if ($('change_year')) {
    $('change_year').on('change', function(event) {
      event.stop();
      event.element().up('form').submit();
    });
  }

});