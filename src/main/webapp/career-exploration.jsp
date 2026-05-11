<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Career Exploration</title>
  <link rel="stylesheet" href="style4.css?v=3">
</head>
<body>

<main class="container">
  <section class="intro">
    <h1>Explore Your Interests</h1>
    <p>If you have different interests in multiple fields, take this psychometric test to find a future field that matches your answers.</p>
    <button id="takeTestBtn">Take Psychometric Test</button>
  </section>

  <form id="testForm" class="test-form">
    <div class="test-progress" aria-live="polite">
      <div>
        <span class="progress-label">Progress</span>
        <strong id="progressText">0 of 8 answered</strong>
      </div>
      <div class="progress-track" aria-hidden="true">
        <span id="progressBar"></span>
      </div>
    </div>
    <div id="questionsContainer"></div>
    <button type="submit" id="submitTestBtn">Calculate Result</button>
  </form>

  <section id="resultBox" class="result-box" aria-live="polite"></section>

  <button id="viewCareerBtn" class="view-button">View Your Career Path</button>
</main>

<script src="script3.js?v=3"></script>

</body>
</html>
