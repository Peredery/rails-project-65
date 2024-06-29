// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener('DOMContentLoaded', () => {
  function previewImage(event) {
    var input = event.target;
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        var imgTag = document.getElementById('image-preview-tag');
        imgTag.src = e.target.result;
        imgTag.style.display = 'block'; 
      };
      reader.readAsDataURL(input.files[0]); 
    }
  }

  window.previewImage = previewImage;
});
