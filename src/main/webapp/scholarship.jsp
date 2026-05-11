<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Scholarship Programs</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- AOS CSS for animations -->
  <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet" />

  <style>
    body {
      background: #f4f7fa;
      font-family: 'Segoe UI', sans-serif;
      background: url('images/sc3.jpeg') no-repeat center center fixed;
      background-size: cover;
    }

    .scholarship-section {
      padding: 50px 20px;
      font-family: 'Dancing Script', cursive;
    }

    .card {
      border: none;
      border-radius: 20px;
      transition: transform 0.4s ease, box-shadow 0.4s ease;
      overflow: hidden;
      position: relative;
      background: white;
    }

    .card:hover {
      transform: translateY(-12px) scale(1.01);
      box-shadow: 0 12px 28px rgba(0, 0, 0, 0.15);
    }

    .card-title {
      font-size: 1.4rem;
      font-weight: 700;
      color: #0d6efd;
    }

    .card-text {
      font-size: 1rem;
      color: #333;
      text-align: justify; /* Justify content */
    }

    .btn-custom {
      background: #0d6efd;
      color: white;
      border-radius: 30px;
      transition: background 0.3s ease, transform 0.3s ease;
    }

    .btn-custom:hover {
      background: #084298;
      transform: scale(1.05);
    }

    /* Common Animation for all cards with delay */
    .card-animation {
      opacity: 0;
      transform: translateY(20px);
      animation: bounceIn 1s ease forwards;
    }

    /* Bounce effect keyframes */
    @keyframes bounceIn {
      0% {
        opacity: 0;
        transform: translateY(20px);
      }
      60% {
        opacity: 1;
        transform: translateY(-10px);
      }
      80% {
        transform: translateY(5px);
      }
      100% {
        transform: translateY(0);
      }
    }

  </style>
</head>
<body>

<section class="scholarship-section container">
  <h2 class="text-center mb-5 fw-bold" data-aos="fade-up">Scholarship Programs</h2>
  <div class="row g-4">

    <!-- Udayan Care -->
    <div class="col-md-6 col-lg-4 card-animation" data-aos="zoom-in" data-aos-delay="0">
      <div class="card p-4 shadow-sm h-100">
        <h5 class="card-title">Udayan Shalini Fellowship (Girls Only)</h5>
        <p class="card-text">
          Udayan Care supports girls at risk of dropping out after Class X, especially those from underprivileged backgrounds. 
          Their fellowship empowers girls to pursue higher education and become confident, independent women.
        </p>
        <a href="https://www.udayancare.org/" target="_blank" class="btn btn-custom">Learn More</a>
      </div>
    </div>

    <!-- Dor Foundation -->
    <div class="col-md-6 col-lg-4 card-animation" data-aos="zoom-in" data-aos-delay="300">
      <div class="card p-4 shadow-sm h-100">
        <h5 class="card-title">Dor Foundation</h5>
        <p class="card-text">
          Founded by Sanyogita Kedia, Dor Foundation partners with private universities to offer admissions and upskilling for underprivileged students.
          Dor Foundation envisions to work with promising youngsters from financially vulnerable backgrounds.
        </p>
        <a href="https://www.dorfoundation.com/" target="_blank" class="btn btn-custom">Visit Site</a>
      </div>
    </div>

    <!-- Mudita College Scholarship -->
    <div class="col-md-6 col-lg-4 card-animation" data-aos="zoom-in" data-aos-delay="600">
      <div class="card p-4 shadow-sm h-100">
        <h5 class="card-title">Mudita College Scholarship</h5>
        <p class="card-text">
          Focused on STEM education in Maharashtra, Mudita supports deserving students through a selection process and holistic workshops.
          The Mudita Scholarship follows a  process—document verification, interviews to assess potential, and direct fee disbursement to colleges.
        </p>
        <a href="https://muditaalliance.org/objectives-of-the-trust/" target="_blank" class="btn btn-custom">Know More</a>
      </div>
    </div>

    <!-- Centered "More Scholarships" Card -->
    <div class="col-12 d-flex justify-content-center card-animation" data-aos="zoom-in" data-aos-delay="900">
      <div class="card p-4 shadow-sm" style="width: 22rem;">
        <h5 class="card-title">More Scholarships</h5>
        <p class="card-text">
          Discover a wide range of other scholarship opportunities for various fields and student needs in this reference link.
        </p>
        <a href="https://www.buddy4study.com/" target="_blank" class="btn btn-custom">Explore All</a>
      </div>
    </div>

  </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS Animation Script -->
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
  AOS.init({
    duration: 1000,
    once: true
  });
</script>

</body>
</html>
