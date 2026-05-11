<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.telusko.DBConnection" %>
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
    String student_email = (String) session.getAttribute("email");
    if (student_email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();

    PreparedStatement ps = conn.prepareStatement(
        "SELECT MIN(u.Firstname) AS Firstname, MIN(u.Lastname) AS Lastname, LOWER(r.email) AS email " +
        "FROM Role r JOIN users u ON LOWER(u.email) = LOWER(r.email) " +
        "WHERE LOWER(r.role) = 'mentor' AND LOWER(r.email) <> LOWER(?) " +
        "AND NOT EXISTS ( " +
        "    SELECT 1 FROM mentorship_requests mr " +
        "    WHERE LOWER(mr.student_email) = LOWER(?) " +
        "    AND LOWER(mr.mentor_email) = LOWER(r.email) " +
        "    AND LOWER(mr.status) IN ('pending', 'accepted') " +
        ") " +
        "GROUP BY LOWER(r.email) " +
        "ORDER BY MIN(u.Firstname), LOWER(r.email)"
    );
    ps.setString(1, student_email);
    ps.setString(2, student_email);
    ResultSet rs = ps.executeQuery();

    PreparedStatement chatPs = conn.prepareStatement(
        "SELECT MIN(u.Firstname) AS Firstname, MIN(u.Lastname) AS Lastname, LOWER(mr.mentor_email) AS email " +
        "FROM mentorship_requests mr LEFT JOIN users u ON LOWER(u.email) = LOWER(mr.mentor_email) " +
        "WHERE LOWER(mr.student_email) = LOWER(?) AND LOWER(mr.status) = 'accepted' " +
        "GROUP BY LOWER(mr.mentor_email) " +
        "ORDER BY MIN(u.Firstname), LOWER(mr.mentor_email)"
    );
    chatPs.setString(1, student_email);
    ResultSet chatRs = chatPs.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mentors</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172033;
        }

        .page {
            width: min(1120px, calc(100% - 28px));
            margin: 24px auto;
        }

        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 18px;
        }

        .title-block h1 {
            margin: 0;
            font-size: 1.8rem;
        }

        .title-block p {
            margin: 6px 0 0;
            color: #637083;
        }

        .actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn,
        .card-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 40px;
            padding: 0 14px;
            border: 1px solid #cfd9e4;
            border-radius: 8px;
            background: #ffffff;
            color: #172033;
            font: inherit;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
        }

        .btn.primary,
        .card-button.primary {
            border-color: #0f766e;
            background: #0f766e;
            color: #ffffff;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 12px;
            margin-bottom: 16px;
        }

        .stat {
            padding: 16px;
            border: 1px solid #d9e2ec;
            border-radius: 8px;
            background: #ffffff;
            box-shadow: 0 12px 28px rgba(23, 32, 51, 0.06);
        }

        .stat strong {
            display: block;
            font-size: 1.5rem;
            color: #0f766e;
        }

        .stat span {
            color: #637083;
            font-size: 0.92rem;
        }

        .panel {
            margin-top: 16px;
            border: 1px solid #d9e2ec;
            border-radius: 8px;
            background: #ffffff;
            box-shadow: 0 18px 42px rgba(23, 32, 51, 0.09);
            overflow: hidden;
        }

        .panel-header {
            display: grid;
            grid-template-columns: 1fr minmax(220px, 340px);
            gap: 14px;
            align-items: center;
            padding: 18px;
            border-bottom: 1px solid #e5ecf3;
        }

        .panel-header h2 {
            margin: 0;
            font-size: 1.14rem;
        }

        .panel-header p {
            margin: 4px 0 0;
            color: #637083;
            font-size: 0.9rem;
        }

        .search {
            width: 100%;
            min-height: 42px;
            border: 1px solid #ccd7e3;
            border-radius: 8px;
            padding: 0 12px;
            font: inherit;
            outline: none;
        }

        .search:focus {
            border-color: #0f766e;
            box-shadow: 0 0 0 4px rgba(15, 118, 110, 0.12);
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 14px;
            padding: 18px;
        }

        .mentor-card {
            display: grid;
            grid-template-columns: auto 1fr;
            gap: 12px;
            align-items: center;
            padding: 14px;
            border: 1px solid #dbe4ee;
            border-radius: 8px;
            background: #fbfdff;
        }

        .avatar {
            width: 46px;
            height: 46px;
            display: grid;
            place-items: center;
            border-radius: 50%;
            background: #0f766e;
            color: #ffffff;
            font-weight: 800;
            text-transform: uppercase;
        }

        .avatar.available {
            background: #1d4ed8;
        }

        .mentor-info {
            min-width: 0;
        }

        .mentor-name {
            margin: 0;
            font-size: 1rem;
            font-weight: 800;
            overflow-wrap: anywhere;
        }

        .mentor-email {
            margin: 4px 0 0;
            color: #637083;
            font-size: 0.9rem;
            overflow-wrap: anywhere;
        }

        .mentor-card form {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            margin: 4px 0 0;
        }

        .empty-state {
            padding: 34px 18px;
            text-align: center;
            color: #637083;
        }

        .empty-state h3 {
            margin: 0 0 8px;
            color: #172033;
        }

        .hidden {
            display: none;
        }

        @media (max-width: 680px) {
            .topbar {
                flex-direction: column;
                align-items: stretch;
            }

            .actions {
                justify-content: flex-start;
            }

            .panel-header {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <main class="page">
        <header class="topbar">
            <div class="title-block">
                <h1>Mentor Hub</h1>
                <p>Continue accepted chats or request guidance from available mentors.</p>
            </div>
            <nav class="actions" aria-label="Student actions">
                <a class="btn primary" href="studentside.jsp">Your Mentors</a>
                <a class="btn" href="career.jsp">Explore Careers</a>
                <a class="btn" href="Logout">Logout</a>
            </nav>
        </header>

        <section class="stats" aria-label="Mentor summary">
            <div class="stat">
                <strong id="chatCount">0</strong>
                <span>Accepted mentor chats</span>
            </div>
            <div class="stat">
                <strong id="availableCount">0</strong>
                <span>Available mentors</span>
            </div>
        </section>

        <section class="panel">
            <div class="panel-header">
                <div>
                    <h2>Your Chat List</h2>
                    <p>Mentors who accepted your request.</p>
                </div>
                <input class="search" id="chatSearch" type="search" placeholder="Search accepted mentors" autocomplete="off">
            </div>

            <div class="card-grid" id="chatGrid">
<%
    boolean hasChats = false;
    while (chatRs.next()) {
        hasChats = true;
        String mentorEmail = chatRs.getString("email");
        String firstName = chatRs.getString("Firstname");
        String lastName = chatRs.getString("Lastname");
        String mentorName = ((firstName == null ? "" : firstName) + " " + (lastName == null ? "" : lastName)).trim();
        if (mentorName.isEmpty()) {
            mentorName = mentorEmail;
        }
        String safeMentorName = escapeHtml(mentorName);
        String safeMentorEmail = escapeHtml(mentorEmail);
%>
                <article class="mentor-card chat-card" data-search="<%= (safeMentorName + " " + safeMentorEmail).toLowerCase() %>">
                    <div class="avatar" aria-hidden="true"><%= safeMentorName.substring(0, 1) %></div>
                    <div class="mentor-info">
                        <p class="mentor-name"><%= safeMentorName %></p>
                        <p class="mentor-email"><%= safeMentorEmail %></p>
                    </div>
                    <form action="chat.jsp" method="get">
                        <input type="hidden" name="chatWith" value="<%= safeMentorEmail %>">
                        <input class="card-button primary" type="submit" value="Open Chat">
                    </form>
                </article>
<%
    }
    if (!hasChats) {
%>
                <div class="empty-state">
                    <h3>No accepted mentors yet</h3>
                    <p>Accepted mentors will appear here with chat access.</p>
                </div>
<%
    }
%>
            </div>
            <div class="empty-state hidden" id="noChatResults">
                <h3>No matching chats</h3>
                <p>Try another mentor name or email.</p>
            </div>
        </section>

        <section class="panel">
            <div class="panel-header">
                <div>
                    <h2>Available Mentors</h2>
                    <p>Send a mentorship request to start learning together.</p>
                </div>
                <input class="search" id="mentorSearch" type="search" placeholder="Search available mentors" autocomplete="off">
            </div>

            <div class="card-grid" id="availableGrid">
<%
    boolean hasAvailableMentors = false;
    while (rs.next()) {
        hasAvailableMentors = true;
        String mentorEmail = rs.getString("email");
        String firstName = rs.getString("Firstname");
        String lastName = rs.getString("Lastname");
        String mentorName = ((firstName == null ? "" : firstName) + " " + (lastName == null ? "" : lastName)).trim();
        if (mentorName.isEmpty()) {
            mentorName = mentorEmail;
        }
        String safeMentorName = escapeHtml(mentorName);
        String safeMentorEmail = escapeHtml(mentorEmail);
%>
                <article class="mentor-card available-card" data-search="<%= (safeMentorName + " " + safeMentorEmail).toLowerCase() %>">
                    <div class="avatar available" aria-hidden="true"><%= safeMentorName.substring(0, 1) %></div>
                    <div class="mentor-info">
                        <p class="mentor-name"><%= safeMentorName %></p>
                        <p class="mentor-email"><%= safeMentorEmail %></p>
                    </div>
                    <form method="post" action="RequestMentorServlet">
                        <input type="hidden" name="mentor_email" value="<%= safeMentorEmail %>">
                        <input class="card-button primary" type="submit" value="Request Mentorship">
                    </form>
                </article>
<%
    }
    if (!hasAvailableMentors) {
%>
                <div class="empty-state">
                    <h3>No mentors available right now</h3>
                    <p>Mentors you requested or already chat with are hidden from this list.</p>
                </div>
<%
    }

    chatRs.close();
    chatPs.close();
    rs.close();
    ps.close();
    conn.close();
%>
            </div>
            <div class="empty-state hidden" id="noAvailableResults">
                <h3>No matching mentors</h3>
                <p>Try another mentor name or email.</p>
            </div>
        </section>
    </main>

    <script>
        function wireSearch(inputId, cardSelector, emptyId) {
            const input = document.getElementById(inputId);
            const cards = Array.from(document.querySelectorAll(cardSelector));
            const empty = document.getElementById(emptyId);

            input.addEventListener("input", function () {
                const query = input.value.trim().toLowerCase();
                let visibleCount = 0;

                cards.forEach(function (card) {
                    const visible = card.dataset.search.includes(query);
                    card.classList.toggle("hidden", !visible);
                    if (visible) {
                        visibleCount++;
                    }
                });

                empty.classList.toggle("hidden", query.length === 0 || visibleCount > 0);
            });

            return cards.length;
        }

        const chatCount = wireSearch("chatSearch", ".chat-card", "noChatResults");
        const availableCount = wireSearch("mentorSearch", ".available-card", "noAvailableResults");

        document.getElementById("chatCount").textContent = chatCount;
        document.getElementById("availableCount").textContent = availableCount;
    </script>
</body>
</html>
