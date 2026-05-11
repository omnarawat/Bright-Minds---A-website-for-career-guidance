document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll(".tab-btn").forEach(function(button) {
    button.addEventListener("click", function() {
      const targetId = button.dataset.target;

      document.querySelectorAll(".tab-btn").forEach(function(item) {
        item.classList.toggle("active", item === button);
      });

      document.querySelectorAll(".tab-panel").forEach(function(panel) {
        panel.classList.toggle("active", panel.id === targetId);
      });
    });
  });

  document.querySelectorAll(".path-card").forEach(function(card) {
    card.addEventListener("click", function() {
      document.querySelectorAll(".path-card").forEach(function(item) {
        item.classList.remove("active");
      });
      card.classList.add("active");
    });
  });
});
