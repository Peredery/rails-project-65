// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("DOMContentLoaded", function() {
    document.querySelector('input[type="file"]').addEventListener("change", previewImage);
  });
  
  function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function() {
      var output = document.getElementById('image-preview-tag');
      output.src = reader.result;
    }
    reader.readAsDataURL(event.target.files[0]);
  }
