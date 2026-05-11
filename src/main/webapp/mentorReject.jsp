<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        return value
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }
%>
<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String studentEmail = request.getParameter("student_email");
    String safeStudentEmail = escapeHtml(studentEmail);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Request Rejected</title>
<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    align-items: center;
    background: linear-gradient(135deg, #f8fafc, #e0f2fe);
    color: #172033;
    display: flex;
    font-family: Arial, Helvetica, sans-serif;
    justify-content: center;
    min-height: 100vh;
    padding: clamp(14px, 4vw, 34px);
}

.shell {
    background: #ffffff;
    border: 1px solid #d9e2ec;
    border-radius: 8px;
    box-shadow: 0 18px 44px rgba(23, 32, 51, 0.14);
    max-width: 980px;
    overflow: hidden;
    width: min(100%, 980px);
}

.hero {
    background: linear-gradient(135deg, #1e3a8a, #0f766e);
    color: #ffffff;
    padding: clamp(28px, 6vw, 54px);
    text-align: center;
}

.status-pill {
    background: rgba(255, 255, 255, 0.12);
    border: 1px solid rgba(255, 255, 255, 0.32);
    border-radius: 999px;
    display: inline-block;
    font-size: 0.82rem;
    font-weight: 800;
    letter-spacing: 0.08em;
    margin-bottom: 14px;
    padding: 8px 14px;
    text-transform: uppercase;
}

.hero h1 {
    font-size: clamp(2rem, 5vw, 3.1rem);
    margin-bottom: 12px;
}

.hero p {
    color: #dbeafe;
    line-height: 1.7;
    margin: 0 auto;
    max-width: 740px;
}

.content {
    padding: clamp(22px, 4vw, 36px);
}

.notice {
    background: #f8fafc;
    border: 1px solid #dbe4ee;
    border-radius: 8px;
    color: #475569;
    line-height: 1.6;
    margin-bottom: 22px;
    padding: 16px;
    text-align: center;
}

.notice strong {
    color: #0f766e;
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
    border: 1px solid #dbe4ee;
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
    font-size: 1.05rem;
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
<main class="shell">
    <section class="hero">
        <span class="status-pill">Mentor Action Complete</span>
        <h1>Request Rejected</h1>
        <p>You have declined this mentorship request. You can return to pending requests, explore the career resources, or share feedback to help improve the platform.</p>
    </section>

    <section class="content">
        <% if (studentEmail != null && !studentEmail.trim().isEmpty()) { %>
            <div class="notice">
                Rejected request  <strong><%= safeStudentEmail %></strong>.
            </div>
        <% } %>

        <div class="next-grid">
            <button class="next-card active" type="button" data-title="Explore Career Resources" data-text="Visit the career section to understand what students are exploring. It can help you guide future students with more context.">
                <strong>Explore Career Resources</strong>
                <span>Review streams, exams, and student learning paths.</span>
            </button>
            <button class="next-card" type="button" data-title="Give Feedback" data-text="Tell us if the request process needs improvement. Your mentor feedback helps us make matching and communication better.">
                <strong>Give Feedback</strong>
                <span>Share suggestions about the mentor workflow.</span>
            </button>
            <button class="next-card" type="button" data-title="Review Requests" data-text="Return to your dashboard to accept or reject other pending requests from students.">
                <strong>Review Requests</strong>
                <span>Go back to your mentor dashboard.</span>
            </button>
        </div>

        <div class="detail-panel" id="detailPanel" aria-live="polite">
            <h2>Explore Career Resources</h2>
            <p>Visit the career section to understand what students are exploring. It can help you guide future students with more context.</p>
        </div>

        <div class="action-row">
            <a class="btn" href="career.jsp">Explore Website</a>
            <a class="btn secondary" href="feedback.jsp">Give Feedback</a>
            <a class="btn secondary" href="mentorDashboard.jsp">Back to Dashboard</a>
        </div>

        <p class="encouragement">A thoughtful rejection keeps the dashboard clean. The next good match may be waiting.</p>
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
