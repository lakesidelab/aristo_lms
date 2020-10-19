
require("trix")
require("jquery-ui")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()


import Sortable from 'sortablejs';
import Rails from '@rails/ujs';
import 'jquery-ui/ui/widgets/sortable'

$( document ).ready(function() {
    console.log( "ready!" );
});


document.addEventListener('turbolinks:load', function(){
  $("#tracks").sortable({
    update: function(e, ui){
      Rails.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      })
    }
  })
});

document.addEventListener('turbolinks:load', function(){
  $("#training-children").sortable({
    update: function(e, ui){
      Rails.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      })
    }
  })
})
