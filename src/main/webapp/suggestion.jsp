<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Your Career Suggestions</title>
  <link rel="stylesheet" href="suggestion.css?v=4">
</head>
<body>

<div class="container">
  <header class="page-header">
    <span>Personalized Result</span>
    <h1>Your Career Suggestions</h1>
    <p>Based on your psychometric test result, here are some career paths for you.</p>
  </header>

  <div class="cards" id="careerCards">
    <!-- Dynamic cards will come here from JS -->
  </div>

  <section class="detail-panel" id="detailPanel" aria-live="polite">
    <span>Click any card</span>
    <h2>View More Information</h2>
    <p>Select a course, career, or field card to see what it means and what you can do next.</p>
  </section>

  <div class="action-row">
    <button id="backButton">Back to Test</button>
    <button id="retakeButton" type="button">Retake Test</button>
  </div>
</div>

<script src="suggestion.js?v=4"></script>
</body>
</html>
