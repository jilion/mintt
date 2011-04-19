document.observe("dom:loaded", function() {

  if ($$('.candidate_selected_contextual_info').any()) {
    $('user_state').on('click', function(event) {
      var checkbox = event.element();
      if (checkbox.checked) $$('.candidate_selected_contextual_info').invoke('show');
      else $$('.candidate_selected_contextual_info').invoke('hide');
    });
  }

  if ($('document_published_at_1i')) {
    $('document_published_at_1i').on('change', function(event) {
      var form = event.element().up('form');
      var params = form.serialize(true);
      console.log(params);
      params['_method'] = null;
      new Ajax.Request('/admin/documents/modules', { method: 'post', parameters: params });
    });
  }

});
