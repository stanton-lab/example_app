//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ru.js
//= require wice_grid
//= require cocoon
//= require maskedinput
//= require jquery.Jcrop
//= require jquery-fileupload
//= require wice_grid
//= require select2-full

//= require_tree
//= require_self

function init() {
  window.loader = new App.Loader();
  window.cropper = new App.ImageCroper();
  
  $('.datepicker').datepicker({
    language: 'ru',
    autoclose: true,
    format: 'dd-mm-yyyy'
  });
  
  $(".phone").mask("(999) 999-99-99");
  $('.phones').on('cocoon:after-insert', function(e, insertedItem) {
    $(insertedItem).find('.phone').mask("(999) 999-99-99")
  });
}

$(document).ready(init);

