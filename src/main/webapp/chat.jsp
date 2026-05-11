<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

    private String formatMessageTime(Object value) {
        if (value == null) {
            return "";
        }
        if (value instanceof Timestamp) {
            return new SimpleDateFormat("dd MMM, hh:mm a").format((Timestamp) value);
        }
        return value.toString();
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    String backPage = "mentor".equalsIgnoreCase(role) ? "mentorDashboard.jsp" : "studentside.jsp";
    String chatWith = request.getParameter("chatWith");
    boolean invalidChat = chatWith == null || chatWith.trim().isEmpty();
    if (!invalidChat) {
        chatWith = chatWith.trim();
    }

    String chatDisplayName = chatWith;
    if (!invalidChat) {
        try (
            Connection nameConn = DBConnection.getConnection();
            PreparedStatement namePs = nameConn.prepareStatement(
                "SELECT Firstname, Lastname FROM users WHERE LOWER(email) = LOWER(?) LIMIT 1"
            )
        ) {
            namePs.setString(1, chatWith);
            try (ResultSet nameRs = namePs.executeQuery()) {
                if (nameRs.next()) {
                    String firstName = nameRs.getString("Firstname");
                    String lastName = nameRs.getString("Lastname");
                    String fullName = ((firstName == null ? "" : firstName) + " " + (lastName == null ? "" : lastName)).trim();
                    if (!fullName.isEmpty()) {
                        chatDisplayName = fullName;
                    }
                }
            }
        } catch (Exception e) {
            chatDisplayName = chatWith;
        }
    }

    String safeChatWith = invalidChat ? "" : escapeHtml(chatWith);
    String safeChatDisplayName = invalidChat ? "" : escapeHtml(chatDisplayName);
    String pageTitle = invalidChat ? "Invalid Chat" : safeChatDisplayName;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, Helvetica, sans-serif;
            background:
                radial-gradient(circle at top left, rgba(20, 184, 166, 0.18), transparent 34%),
                linear-gradient(135deg, #edf7f5 0%, #f6f8fb 48%, #eef3ff 100%);
            color: #172033;
        }

        .chat-shell {
            width: min(980px, calc(100% - 28px));
            min-height: calc(100vh - 36px);
            margin: 18px auto;
            display: grid;
            grid-template-rows: auto 1fr auto;
            border: 1px solid #d8e2ed;
            border-radius: 8px;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.94);
            box-shadow: 0 20px 50px rgba(32, 45, 64, 0.14);
        }

        .empty-state {
            width: min(420px, calc(100% - 32px));
            margin: 14vh auto;
            padding: 28px;
            border: 1px solid #d7e1ec;
            border-radius: 8px;
            background: #ffffff;
            text-align: center;
            box-shadow: 0 16px 40px rgba(31, 41, 55, 0.08);
        }

        .empty-state a {
            display: inline-block;
            margin-top: 12px;
            color: #0f766e;
            font-weight: 700;
            text-decoration: none;
        }

        .chat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 18px 22px;
            background: #ffffff;
            border-bottom: 1px solid #e3e9f0;
        }

        .contact {
            display: flex;
            align-items: center;
            min-width: 0;
            gap: 12px;
        }

        .avatar {
            width: 44px;
            height: 44px;
            flex: 0 0 44px;
            display: grid;
            place-items: center;
            border-radius: 50%;
            background: #0f766e;
            color: #ffffff;
            font-weight: 800;
            text-transform: uppercase;
        }

        .contact h1 {
            margin: 0;
            font-size: 1.12rem;
            line-height: 1.25;
            word-break: break-word;
        }

        .status {
            display: flex;
            align-items: center;
            gap: 7px;
            margin-top: 4px;
            color: #64748b;
            font-size: 0.86rem;
        }

        .status-dot {
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background: #22c55e;
            box-shadow: 0 0 0 4px rgba(34, 197, 94, 0.14);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-box {
            width: min(260px, 28vw);
            border: 1px solid #d3dce6;
            border-radius: 8px;
            padding: 10px 12px;
            font: inherit;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .search-box:focus {
            border-color: #0f766e;
            box-shadow: 0 0 0 4px rgba(15, 118, 110, 0.12);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 40px;
            padding: 0 14px;
            border: 1px solid #cfd9e4;
            border-radius: 8px;
            color: #1f2937;
            font-weight: 700;
            text-decoration: none;
            background: #ffffff;
        }

        .messages {
            padding: 22px;
            overflow-y: auto;
            background:
                linear-gradient(rgba(255, 255, 255, 0.84), rgba(255, 255, 255, 0.84)),
                repeating-linear-gradient(45deg, #edf2f7 0, #edf2f7 1px, transparent 1px, transparent 18px);
        }

        .day-label {
            width: fit-content;
            margin: 0 auto 18px;
            padding: 6px 12px;
            border-radius: 999px;
            background: #e8f3f1;
            color: #0f766e;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .message-row {
            display: flex;
            margin: 12px 0;
        }

        .message-row.sent {
            justify-content: flex-end;
        }

        .message-card {
            max-width: min(620px, 76%);
            padding: 11px 13px 9px;
            border-radius: 8px;
            border: 1px solid #dbe4ee;
            background: #ffffff;
            box-shadow: 0 8px 22px rgba(31, 41, 55, 0.08);
        }

        .message-row.sent .message-card {
            border-color: #0f766e;
            background: #0f766e;
            color: #ffffff;
        }

        .message-text {
            margin: 0;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
            line-height: 1.45;
        }

        .message-meta {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 7px;
            color: #718096;
            font-size: 0.75rem;
        }

        .message-row.sent .message-meta {
            color: rgba(255, 255, 255, 0.78);
        }

        .no-messages {
            height: 100%;
            display: grid;
            place-items: center;
            text-align: center;
            color: #64748b;
        }

        .composer {
            padding: 14px 18px 16px;
            border-top: 1px solid #e3e9f0;
            background: #ffffff;
        }

        .quick-replies {
            display: flex;
            gap: 8px;
            margin-bottom: 10px;
            overflow-x: auto;
            padding-bottom: 2px;
        }

        .quick-reply {
            flex: 0 0 auto;
            border: 1px solid #d3dce6;
            border-radius: 999px;
            padding: 8px 12px;
            color: #344054;
            background: #f8fafc;
            font: inherit;
            cursor: pointer;
        }

        .quick-reply:hover {
            border-color: #0f766e;
            color: #0f766e;
            background: #edf7f5;
        }

        .compose-row {
            display: grid;
            grid-template-columns: 1fr auto;
            align-items: end;
            gap: 10px;
        }

        textarea {
            width: 100%;
            min-height: 54px;
            max-height: 160px;
            resize: none;
            border: 1px solid #cfd9e4;
            border-radius: 8px;
            padding: 13px 14px;
            font: inherit;
            line-height: 1.4;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        textarea:focus {
            border-color: #0f766e;
            box-shadow: 0 0 0 4px rgba(15, 118, 110, 0.12);
        }

        .send-button {
            min-height: 54px;
            border: 0;
            border-radius: 8px;
            padding: 0 22px;
            background: #0f766e;
            color: #ffffff;
            font: inherit;
            font-weight: 800;
            cursor: pointer;
            transition: transform 0.16s, background 0.16s, opacity 0.16s;
        }

        .send-button:hover {
            background: #115e59;
            transform: translateY(-1px);
        }

        .send-button:disabled {
            cursor: not-allowed;
            opacity: 0.55;
            transform: none;
        }

        .compose-footer {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            margin-top: 8px;
            color: #64748b;
            font-size: 0.8rem;
        }

        .highlight {
            outline: 3px solid rgba(245, 158, 11, 0.42);
        }

        @media (max-width: 680px) {
            .chat-shell {
                width: 100%;
                min-height: 100vh;
                margin: 0;
                border: 0;
                border-radius: 0;
            }

            .chat-header {
                align-items: flex-start;
                flex-direction: column;
                padding: 16px;
            }

            .header-actions {
                width: 100%;
            }

            .search-box {
                width: 100%;
            }

            .back-link {
                flex: 0 0 auto;
            }

            .messages {
                padding: 16px 12px;
            }

            .message-card {
                max-width: 86%;
            }

            .composer {
                padding: 12px;
            }

            .compose-row {
                grid-template-columns: 1fr;
            }

            .send-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<% if (invalidChat) { %>
    <main class="empty-state">
        <h2>Invalid chat partner selected</h2>
        <p>Please go back and choose a mentor or student to continue chatting.</p>
        <a href="<%= backPage %>">Go Back</a>
    </main>
<% } else { %>
    <main class="chat-shell">
        <header class="chat-header">
            <div class="contact">
                <div class="avatar" aria-hidden="true"><%= safeChatDisplayName.substring(0, 1) %></div>
                <div>
                    <h1><%= safeChatDisplayName %></h1>
                    <div class="status">
                        <span class="status-dot" aria-hidden="true"></span>
                        <span>Conversation ready</span>
                    </div>
                </div>
            </div>
            <div class="header-actions">
                <input class="search-box" id="messageSearch" type="search" placeholder="Search messages" autocomplete="off">
                <a class="back-link" href="<%= backPage %>">Back</a>
                <a class="back-link" href="Logout">Logout</a>
            </div>
        </header>

        <section class="messages" id="messages" aria-live="polite">
            <div class="day-label">Messages</div>
<%
    boolean hasMessages = false;

    try (
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "SELECT sender_email, message, timestamp FROM messages " +
            "WHERE (sender_email=? AND receiver_email=?) OR (sender_email=? AND receiver_email=?) " +
            "ORDER BY timestamp"
        )
    ) {
        ps.setString(1, email);
        ps.setString(2, chatWith);
        ps.setString(3, chatWith);
        ps.setString(4, email);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                hasMessages = true;
                String sender = rs.getString("sender_email");
                String message = rs.getString("message");
                Object time = rs.getObject("timestamp");
                boolean sentByMe = email.equals(sender);
%>
            <article class="message-row <%= sentByMe ? "sent" : "received" %>" data-message="<%= escapeHtml(message).toLowerCase() %>">
                <div class="message-card">
                    <p class="message-text"><%= escapeHtml(message) %></p>
                    <div class="message-meta">
                        <span><%= sentByMe ? "You" : escapeHtml(sender) %></span>
                        <span><%= escapeHtml(formatMessageTime(time)) %></span>
                    </div>
                </div>
            </article>
<%
            }
        }
    } catch (Exception e) {
%>
            <div class="no-messages">
                <p>Unable to load messages right now: <%= escapeHtml(e.getMessage()) %></p>
            </div>
<%
    }

    if (!hasMessages) {
%>
            <div class="no-messages" id="emptyState">
                <p>No messages yet. Start the conversation with a quick hello.</p>
            </div>
<%
    }
%>
        </section>

        <form class="composer" method="post" action="SendMessageServlet" id="chatForm">
            <input type="hidden" name="receiver_email" value="<%= safeChatWith %>">

            <div class="quick-replies" aria-label="Quick replies">
                <button type="button" class="quick-reply" data-text="Hi, I wanted to ask about my progress.">Progress update</button>
                <button type="button" class="quick-reply" data-text="Can we schedule a quick discussion?">Schedule discussion</button>
                <button type="button" class="quick-reply" data-text="Thank you for your guidance.">Say thanks</button>
            </div>

            <div class="compose-row">
                <textarea id="messageInput" name="message" maxlength="500" placeholder="Type your message..." required></textarea>
                <button class="send-button" id="sendButton" type="submit" disabled>Send</button>
            </div>

            <div class="compose-footer">
                <span>Press Enter to send, Shift + Enter for a new line.</span>
                <span id="charCount">0 / 500</span>
            </div>
        </form>
    </main>

    <script>
        const messages = document.getElementById("messages");
        const form = document.getElementById("chatForm");
        const input = document.getElementById("messageInput");
        const sendButton = document.getElementById("sendButton");
        const charCount = document.getElementById("charCount");
        const search = document.getElementById("messageSearch");

        function resizeInput() {
            input.style.height = "auto";
            input.style.height = Math.min(input.scrollHeight, 160) + "px";
        }

        function updateComposer() {
            const length = input.value.length;
            charCount.textContent = length + " / 500";
            sendButton.disabled = input.value.trim().length === 0;
            resizeInput();
        }

        function scrollToLatest() {
            messages.scrollTop = messages.scrollHeight;
        }

        input.addEventListener("input", updateComposer);

        input.addEventListener("keydown", function (event) {
            if (event.key === "Enter" && !event.shiftKey) {
                event.preventDefault();
                if (input.value.trim().length > 0) {
                    form.requestSubmit();
                }
            }
        });

        document.querySelectorAll(".quick-reply").forEach(function (button) {
            button.addEventListener("click", function () {
                input.value = button.dataset.text;
                input.focus();
                updateComposer();
            });
        });

        search.addEventListener("input", function () {
            const term = search.value.trim().toLowerCase();
            const rows = document.querySelectorAll(".message-row");
            let firstMatch = null;

            rows.forEach(function (row) {
                const isMatch = term.length > 0 && row.dataset.message.includes(term);
                row.classList.toggle("highlight", isMatch);
                if (isMatch && firstMatch === null) {
                    firstMatch = row;
                }
            });

            if (firstMatch) {
                firstMatch.scrollIntoView({ behavior: "smooth", block: "center" });
            }
        });

        window.addEventListener("load", function () {
            updateComposer();
            scrollToLatest();
            input.focus();
        });
    </script>
<% } %>
</body>
</html>
