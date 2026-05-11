<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.telusko.DBConnection" %>
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
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT MIN(u.Firstname) AS Firstname, MIN(u.Lastname) AS Lastname, LOWER(mr.mentor_email) AS mentor_email " +
        "FROM mentorship_requests mr LEFT JOIN users u ON LOWER(u.email) = LOWER(mr.mentor_email) " +
        "WHERE LOWER(mr.student_email) = LOWER(?) AND LOWER(mr.status) = 'accepted' " +
        "GROUP BY LOWER(mr.mentor_email) " +
        "ORDER BY MIN(u.Firstname), LOWER(mr.mentor_email)"
    );
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();

    PreparedStatement rejectedPs = conn.prepareStatement(
        "SELECT MIN(u.Firstname) AS Firstname, MIN(u.Lastname) AS Lastname, LOWER(mr.mentor_email) AS mentor_email " +
        "FROM mentorship_requests mr LEFT JOIN users u ON LOWER(u.email) = LOWER(mr.mentor_email) " +
        "WHERE LOWER(mr.student_email) = LOWER(?) AND LOWER(mr.status) = 'rejected' " +
        "GROUP BY LOWER(mr.mentor_email) " +
        "ORDER BY MIN(u.Firstname), LOWER(mr.mentor_email)"
    );
    rejectedPs.setString(1, email);
    ResultSet rejectedRs = rejectedPs.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Chats</title>
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
            width: min(1040px, calc(100% - 28px));
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
            font-size: 1.75rem;
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
        .chat-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 40px;
            padding: 0 14px;
            border: 1px solid #cfd9e4;
            border-radius: 8px;
            background: #ffffff;
            color: #172033;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
        }

        .btn.primary,
        .chat-button {
            border-color: #0f766e;
            background: #0f766e;
            color: #ffffff;
        }

        .panel {
            border: 1px solid #d9e2ec;
            border-radius: 8px;
            background: #ffffff;
            box-shadow: 0 18px 42px rgba(23, 32, 51, 0.09);
            overflow: hidden;
        }

        .notice-panel {
            border: 1px solid #fecaca;
            border-radius: 8px;
            background: #fff7f7;
            box-shadow: 0 14px 32px rgba(153, 27, 27, 0.08);
            margin-bottom: 18px;
            padding: 18px;
        }

        .notice-panel h2 {
            color: #991b1b;
            margin: 0 0 8px;
            font-size: 1.15rem;
        }

        .notice-panel p {
            color: #6b1d1d;
            margin: 0 0 14px;
        }

        .rejected-list {
            display: grid;
            gap: 10px;
        }

        .rejected-card {
            align-items: center;
            background: #ffffff;
            border: 1px solid #fecaca;
            border-radius: 8px;
            display: grid;
            gap: 12px;
            grid-template-columns: 1fr auto;
            padding: 12px;
        }

        .rejected-message {
            color: #334155;
            line-height: 1.45;
        }

        .rejected-message strong {
            color: #0f766e;
            font-size: 1.05rem;
        }

        .rejected-card strong,
        .rejected-card span {
            overflow-wrap: anywhere;
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
            font-size: 1.1rem;
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

        .mentor-grid {
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
            .topbar,
            .panel-header {
                grid-template-columns: 1fr;
                flex-direction: column;
                align-items: stretch;
            }

            .actions {
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
    <main class="page">
        <header class="topbar">
            <div class="title-block">
                <h1>Your Mentors</h1>
                <p>Open chats with mentors who accepted your request.</p>
            </div>
            <nav class="actions" aria-label="Student actions">
                <a class="btn primary" href="mentorlist.jsp">Find Mentors</a>
                <a class="btn" href="career.jsp">Explore Careers</a>
                <a class="btn" href="Logout">Logout</a>
            </nav>
        </header>

<%
        boolean hasRejected = false;
        int rejectedCount = 0;
        String rejectedSummary = "";
        StringBuilder rejectedMarkup = new StringBuilder();
        while (rejectedRs.next()) {
            hasRejected = true;
            rejectedCount++;
            String mentorEmailRejected = rejectedRs.getString("mentor_email");
            String firstNameRejected = rejectedRs.getString("Firstname");
            String lastNameRejected = rejectedRs.getString("Lastname");
            String mentorNameRejected = ((firstNameRejected == null ? "" : firstNameRejected) + " " + (lastNameRejected == null ? "" : lastNameRejected)).trim();
            if (mentorNameRejected.isEmpty()) {
                mentorNameRejected = mentorEmailRejected;
            }
            String safeRejectedName = escapeHtml(mentorNameRejected);
            String safeRejectedEmail = escapeHtml(mentorEmailRejected);
            if (rejectedCount == 1) {
                rejectedSummary = "Rejected request from <strong>" + safeRejectedName + "</strong>.";
            }
            rejectedMarkup.append("<article class=\"rejected-card\"><div class=\"rejected-message\"><strong>")
                .append(safeRejectedName)
                .append("</strong><br><span>")
                .append(safeRejectedEmail)
                .append("</span></div><a class=\"btn primary\" href=\"reject.jsp\">View Details</a></article>");
        }

        rejectedRs.close();
        rejectedPs.close();

        if (hasRejected) {
%>
        <section class="notice-panel">
            <h2>Mentorship Request Update</h2>
            <p>
                <% if (rejectedCount == 1) { %>
                    <%= rejectedSummary %>
                <% } else { %>
                    Some mentors could not accept your request right now. You can view each update and choose your next step.
                <% } %>
            </p>
            <div class="rejected-list">
                <%= rejectedMarkup.toString() %>
            </div>
        </section>
<%
        }
%>

        <section class="panel">
            <div class="panel-header">
                <h2>Chat List</h2>
                <input class="search" id="mentorSearch" type="search" placeholder="Search mentor name or email" autocomplete="off">
            </div>

            <div class="mentor-grid" id="mentorGrid">
<%
    boolean hasMentors = false;
    while (rs.next()) {
        hasMentors = true;
        String mentorEmail = rs.getString("mentor_email");
        String firstName = rs.getString("Firstname");
        String lastName = rs.getString("Lastname");
        String mentorName = ((firstName == null ? "" : firstName) + " " + (lastName == null ? "" : lastName)).trim();
        if (mentorName.isEmpty()) {
            mentorName = mentorEmail;
        }
        String safeMentorName = escapeHtml(mentorName);
        String safeMentorEmail = escapeHtml(mentorEmail);
%>
                <article class="mentor-card" data-search="<%= (safeMentorName + " " + safeMentorEmail).toLowerCase() %>">
                    <div class="avatar" aria-hidden="true"><%= safeMentorName.substring(0, 1) %></div>
                    <div class="mentor-info">
                        <p class="mentor-name"><%= safeMentorName %></p>
                        <p class="mentor-email"><%= safeMentorEmail %></p>
                    </div>
                    <form action="chat.jsp" method="get">
                        <input type="hidden" name="chatWith" value="<%= safeMentorEmail %>">
                        <input class="chat-button" type="submit" value="Open Chat">
                    </form>
                </article>
<%
    }

    if (!hasMentors) {
%>
                <div class="empty-state" id="emptyState">
                    <h3>No accepted mentors yet</h3>
                    <p>Visit the mentor list and request mentorship to start chatting.</p>
                    <a class="btn primary" href="mentorlist.jsp">Find Mentors</a>
                </div>
<%
    }

    rs.close();
    ps.close();
    conn.close();
%>
            </div>
            <div class="empty-state hidden" id="noResults">
                <h3>No matching mentors</h3>
                <p>Try searching with a different name or email.</p>
            </div>
        </section>
    </main>

    <script>
        const searchInput = document.getElementById("mentorSearch");
        const cards = Array.from(document.querySelectorAll(".mentor-card"));
        const noResults = document.getElementById("noResults");

        searchInput.addEventListener("input", function () {
            const query = searchInput.value.trim().toLowerCase();
            let visibleCount = 0;

            cards.forEach(function (card) {
                const visible = card.dataset.search.includes(query);
                card.classList.toggle("hidden", !visible);
                if (visible) {
                    visibleCount++;
                }
            });

            noResults.classList.toggle("hidden", query.length === 0 || visibleCount > 0);
        });
    </script>
</body>
</html>
