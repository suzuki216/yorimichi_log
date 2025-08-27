document.addEventListener("turbolinks:load", function() {
  document.querySelectorAll(".clickable-image").forEach(function(el) {
    el.addEventListener("click", function() {
      var imgUrl = this.dataset.imgUrl;
      var modalImg = document.getElementById("modalImage");
      if (modalImg && imgUrl) {
        modalImg.src = imgUrl;
      }
    });
  });
});
