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
  
});