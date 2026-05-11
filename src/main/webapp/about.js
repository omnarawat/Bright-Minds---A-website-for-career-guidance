document.addEventListener("DOMContentLoaded", function() {
  const copyEmailBtn = document.getElementById("copyEmailBtn");
  const copyMessage = document.getElementById("copyMessage");
  const email = "omnarawat29@gmail.com";

  document.querySelectorAll(".stat-card").forEach(function(card) {
    card.addEventListener("click", function() {
      const panelId = card.dataset.panel;

      document.querySelectorAll(".stat-card").forEach(function(item) {
        item.classList.toggle("active", item === card);
      });

      document.querySelectorAll(".about-panel").forEach(function(panel) {
        panel.classList.toggle("active", panel.id === panelId);
      });
    });
  });

  copyEmailBtn.addEventListener("click", function() {
    if (navigator.clipboard) {
      navigator.clipboard.writeText(email).then(function() {
        copyMessage.textContent = "Email copied: " + email;
      });
    } else {
      copyMessage.textContent = email;
    }
  });
});
