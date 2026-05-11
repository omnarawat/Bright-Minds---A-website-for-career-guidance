<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>About BrightMinds</title>
  <link rel="stylesheet" href="about.css">
</head>
<body>
  <main id="about-us" class="about-page">
    <section class="about-hero">
      <div class="brand-mark">
        <img src="images/carrerguide.logo.png" alt="BrightMinds Logo">
      </div>
      <span>About Us</span>
      <h1>BrightMinds Career Guide</h1>
      <p>We help students explore streams, compare career paths, prepare for exams, and find guidance that matches their interests.</p>
      <div class="hero-actions">
        <a href="career.jsp">Explore Streams</a>
        <a href="feedback.jsp">Share Feedback</a>
      </div>
    </section>

    <section class="stats-grid" aria-label="BrightMinds highlights">
      <button class="stat-card active" type="button" data-panel="missionPanel">
        <strong>Mission</strong>
        <span>Career clarity</span>
      </button>
      <button class="stat-card" type="button" data-panel="supportPanel">
        <strong>Support</strong>
        <span>Mentorship and resources</span>
      </button>
      <button class="stat-card" type="button" data-panel="valuesPanel">
        <strong>Values</strong>
        <span>Confidence and access</span>
      </button>
    </section>

    <section class="info-panel">
      <article id="missionPanel" class="about-panel active">
        <h2>Our Mission</h2>
        <p>BrightMinds makes career exploration easier for students by turning confusing choices into simple, structured paths. Students can explore streams like engineering, medical, commerce, arts, law, and defence with practical course and exam information.</p>
      </article>
      <article id="supportPanel" class="about-panel">
        <h2>How We Support Students</h2>
        <p>The platform combines psychometric guidance, stream pages, exam resources, scholarship direction, and mentorship tools. The goal is to help students move from “I am confused” to “I know what to explore next.”</p>
      </article>
      <article id="valuesPanel" class="about-panel">
        <h2>What We Believe</h2>
        <p>Every student deserves clear guidance, patient support, and honest information. BrightMinds focuses on practical next steps instead of pressure, so students can choose with confidence.</p>
      </article>
    </section>

    <section class="team-section">
      <h2>What You Can Do Here</h2>
      <div class="feature-grid">
        <div class="feature-card">
          <h3>Explore Career Streams</h3>
          <p>Open detailed pages for streams and learn about courses, exams, skills, and future roles.</p>
        </div>
        <div class="feature-card">
          <h3>Take Psychometric Test</h3>
          <p>Answer interest-based questions and get suggested fields based on your choices.</p>
        </div>
        <div class="feature-card">
          <h3>Use Student Resources</h3>
          <p>Find notes, exam details, scholarship direction, and useful preparation links.</p>
        </div>
      </div>
    </section>

    <section class="contact-card">
      <div>
        <h2>Contact BrightMinds</h2>
        <p>31, Guru Road, Gandhi Gram, Patel Nagar, Dehradun, Uttarakhand 248001</p>
        <p><strong>Phone:</strong> +91-8445765456</p>
        <p><strong>Email:</strong> omnarawat29@gmail.com</p>
      </div>
      <div class="contact-actions">
        <button type="button" id="copyEmailBtn">Copy Email</button>
        <a href="mailto:omnarawat29@gmail.com">Send Mail</a>
      </div>
      <p id="copyMessage" class="copy-message" aria-live="polite"></p>
    </section>

    <section class="faq-section">
      <h2>Quick Questions</h2>
      <details>
        <summary>Who is this platform for?</summary>
        <p>Students who want help choosing streams, careers, entrance exams, scholarships, and mentors.</p>
      </details>
      <details>
        <summary>Can I compare different streams?</summary>
        <p>Yes. Start from Career Exploration and open each stream page to compare subjects, exams, courses, and jobs.</p>
      </details>
      <details>
        <summary>Does the psychometric test decide my final career?</summary>
        <p>No. It gives a suggestion based on your answers. Use it as guidance along with research, marks, interests, and mentor advice.</p>
      </details>
    </section>

    <div class="back-row">
      <a href="career.jsp">Back to Career Page</a>
    </div>
  </main>

  <script src="about.js"></script>
</body>
</html>
