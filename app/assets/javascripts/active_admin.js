//= require arctic_admin/base
//= require activeadmin_addons/all
//= require ckeditor/config
//= require activeadmin/froala_editor/froala_editor.pkgd.min
//= require activeadmin/froala_editor_input
//= require_tree .
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input

document.addEventListener('DOMContentLoaded', function() {
  const numericInputs = document.querySelectorAll('.numeric-input');
  numericInputs.forEach(function(input) {
    console.log('doneee')
    input.addEventListener('input', function() {
      this.value = this.value.replace(/[^0-9.]/g, '');
    });
  });
});

