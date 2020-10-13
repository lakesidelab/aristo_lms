import Sortable from 'sortablejs';

$( document ).ready(function() {
    console.log( "training ready!" );
});

document.addEventListener('turbolinks:load', function(){
  console.log("Sortable: ", Sortable)
  var el = document.getElementById('tracks');
  var sortable = Sortable.create(el);
});
