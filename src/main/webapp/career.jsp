<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Choose Your Stream</title>
    <link rel="stylesheet" href="style1.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet">
</head>
<body class="career-page">

    <!-- Reusable Navbar -->
    <jsp:include page="navbar.jsp" />

    <!-- Page-specific content -->
    <div class="stream-container">
        <h1 class="stream-title">Choose Your Career Stream</h1>
        <p class="stream-subtitle"><b>Explore your interests and build your future with confidence!</b></p>

        <div class="stream-buttons">
            <div class="stream-card" onclick="location.href='engineering.jsp'">
                <h2>Engineering</h2>
                <p>Explore technology and innovation.</p>
            </div>
            <div class="stream-card" onclick="location.href='medical.jsp'">
                <h2>Medical</h2>
                <p>Serve people and study life sciences.</p>
            </div>
            <div class="stream-card" onclick="location.href='commerce.jsp'">
                <h2>Commerce</h2>
                <p>Dive into business and economics.</p>
            </div>
            <div class="stream-card" onclick="location.href='arts.jsp'">
                <h2>Arts</h2>
                <p>Creativity, literature and expression.</p>
            </div>
            <div class="stream-card" onclick="location.href='defence.jsp'">
                <h2>Defence</h2>
                <p>Join the Army, Navy, or Air Force.</p>
            </div>
            <div class="stream-card" onclick="location.href='law.jsp'">
                <h2>Law</h2>
                <p>Uphold justice and explore legal systems.</p>
            </div>
        </div> 
    </div>

</body>
</html>
