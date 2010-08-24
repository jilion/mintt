document.observe("dom:loaded", function() {
  
  if($$('.candidate_selected_contextual_info').any()) {
    $('user_state').on('click', function(event) {
      var checkbox = event.element();
      if(checkbox.checked) $$('.candidate_selected_contextual_info').invoke('show');
      else $$('.candidate_selected_contextual_info').invoke('hide');
    });
  }
  
});