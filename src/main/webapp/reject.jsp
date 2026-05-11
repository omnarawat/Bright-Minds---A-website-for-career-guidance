<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mentorship Request Update</title>
<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    align-items: center;
    background: linear-gradient(135deg, #e0f2fe, #ecfdf5);
    color: #1f2937;
    display: flex;
    font-family: Arial, sans-serif;
    justify-content: center;
    min-height: 100vh;
    overflow-x: hidden;
    padding: clamp(14px, 4vw, 34px);
}

.reject-shell {
    background: #ffffff;
    border: 1px solid #dbeafe;
    border-radius: 8px;
    box-shadow: 0 16px 38px rgba(15, 23, 42, 0.16);
    max-width: 980px;
    overflow: hidden;
    width: min(100%, 980px);
}

.hero {
    background: linear-gradient(135deg, #082f49, #0f766e);
    color: #ffffff;
    padding: clamp(28px, 6vw, 54px);
    text-align: center;
}

.status-pill {
    background: rgba(250, 204, 21, 0.16);
    border: 1px solid rgba(250, 204, 21, 0.45);
    border-radius: 999px;
    color: #facc15;
    display: inline-block;
    font-size: 0.82rem;
    font-weight: 800;
    letter-spacing: 0.08em;
    margin-bottom: 14px;
    padding: 8px 14px;
    text-transform: uppercase;
}

.hero h1 {
    font-size: clamp(2rem, 5vw, 3.2rem);
    margin-bottom: 12px;
}

.hero p {
    color: #dbeafe;
    line-height: 1.7;
    margin: 0 auto;
    max-width: 720px;
}

.content {
    padding: clamp(22px, 4vw, 36px);
}

.next-grid {
    display: grid;
    gap: 16px;
    grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
    margin-bottom: 24px;
}

.next-card,
.detail-panel {
    background: #f8fafc;
    border: 1px solid #dbeafe;
    border-radius: 8px;
    padding: 18px;
}

.next-card {
    cursor: pointer;
    text-align: left;
    transition: border-color 0.2s ease, box-shadow 0.2s ease, transform 0.2s ease;
}

.next-card:hover,
.next-card.active {
    background: #eff6ff;
    border-color: #2563eb;
    box-shadow: 0 12px 24px rgba(37, 99, 235, 0.14);
    transform: translateY(-4px);
}

.next-card strong {
    color: #172554;
    display: block;
    font-size: 1.1rem;
    margin-bottom: 8px;
}

.next-card span {
    color: #4b5563;
    line-height: 1.55;
}

.detail-panel {
    background: #ffffff;
    margin-bottom: 24px;
}

.detail-panel h2 {
    color: #172554;
    margin-bottom: 10px;
}

.detail-panel p {
    color: #4b5563;
    line-height: 1.65;
}

.action-row {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    justify-content: center;
}

.btn {
    background: #2563eb;
    border: 0;
    border-radius: 6px;
    color: #ffffff;
    cursor: pointer;
    font-size: 1rem;
    font-weight: 800;
    padding: 12px 18px;
    text-decoration: none;
    transition: background 0.2s ease, transform 0.2s ease;
}

.btn:hover {
    background: #0f766e;
    transform: translateY(-1px);
}

.btn.secondary {
    background: #334155;
}

.btn.secondary:hover {
    background: #172554;
}

.encouragement {
    color: #0f766e;
    font-weight: 800;
    margin-top: 18px;
    text-align: center;
}

@media (max-width: 560px) {
    .btn {
        text-align: center;
        width: 100%;
    }
}
</style>
</head>
<body>
<main class="reject-shell">
    <section class="hero">
        <span class="status-pill">Request Update</span>
        <h1>Mentorship Request Declined</h1>
        <p>This mentor may be busy right now, but your career journey is still wide open. Choose a next step below and keep moving toward the right guidance.</p>
    </section>

    <section class="content">
        <div class="next-grid">
            <button class="next-card active" type="button" data-title="Explore Career Streams" data-text="Open the stream page and compare Engineering, Medical, Commerce, Arts, Defence, and Law. This helps you keep learning even while waiting for another mentor.">
                <strong>Explore Career Streams</strong>
                <span>Compare courses, exams, skills, and careers.</span>
            </button>
            <button class="next-card" type="button" data-title="Request Another Mentor" data-text="You can go back to the mentor list and send a request to another available mentor. A different mentor may be free to guide you sooner.">
                <strong>Request Another Mentor</strong>
                <span>Find someone else who can guide you.</span>
            </button>
            <button class="next-card" type="button" data-title="Take Psychometric Test" data-text="If you are unsure about your direction, the psychometric test can suggest a field based on your interests and choices.">
                <strong>Take Psychometric Test</strong>
                <span>Get a career suggestion from your answers.</span>
            </button>
        </div>

        <div class="detail-panel" id="detailPanel" aria-live="polite">
            <h2>Explore Career Streams</h2>
            <p>Open the stream page and compare Engineering, Medical, Commerce, Arts, Defence, and Law. This helps you keep learning even while waiting for another mentor.</p>
        </div>

        <div class="action-row">
            <a class="btn" href="career.jsp">Explore Website</a>
            <a class="btn" href="mentorlist.jsp">Find Another Mentor</a>
            <a class="btn secondary" href="career-exploration.jsp">Take Test</a>
            
        </div>

        <p class="encouragement">One declined request is not the end.</p>
    </section>
</main>

<script>
document.querySelectorAll(".next-card").forEach(function(card) {
    card.addEventListener("click", function() {
        document.querySelectorAll(".next-card").forEach(function(item) {
            item.classList.remove("active");
        });

        card.classList.add("active");

        document.getElementById("detailPanel").innerHTML =
            "<h2>" + card.dataset.title + "</h2><p>" + card.dataset.text + "</p>";
    });
});
</script>
</body>
</html>
