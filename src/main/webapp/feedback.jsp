<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.telusko.DBConnection" %>
<%!
    private String cleanValue(Object value) {
        return value == null ? "" : value.toString().trim();
    }

    private String escapeHtml(String value) {
        return value
                .replace("&", "&amp;")
                .replace("\"", "&quot;")
                .replace("<", "&lt;")
                .replace(">", "&gt;");
    }

    private String cookieValue(Cookie[] cookies, String cookieName) {
        if (cookies == null) {
            return "";
        }

        for (Cookie cookie : cookies) {
            if (cookieName.equals(cookie.getName())) {
                return cleanValue(cookie.getValue());
            }
        }

        return "";
    }
%>
<%
    String savedEmail = cleanValue(session.getAttribute("email"));
    String savedName = cleanValue(session.getAttribute("name"));

    if (savedEmail.isEmpty()) {
        savedEmail = cookieValue(request.getCookies(), "loggedInUser");
        if (!savedEmail.isEmpty()) {
            session.setAttribute("email", savedEmail);
        }
    }

    if (!savedEmail.isEmpty() && savedName.isEmpty()) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT Firstname, Lastname FROM users WHERE LOWER(TRIM(Email)) = LOWER(TRIM(?)) LIMIT 1")) {
            preparedStatement.setString(1, savedEmail);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    savedName = (cleanValue(resultSet.getString("Firstname")) + " " +
                            cleanValue(resultSet.getString("Lastname"))).trim();
                }
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        if (savedName.isEmpty() && savedEmail.contains("@")) {
            savedName = savedEmail.substring(0, savedEmail.indexOf("@"));
        }

        session.setAttribute("name", savedName);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Form</title>
    <link rel="stylesheet" href="feedback.css?v=6">
</head>
<body>
    <div class="feedback-container">
        <div class="feedback-header">
            <span>MiniApp Feedback</span>
            <h1>We Value Your Feedback!</h1>
            <p>Please provide your feedback and suggestions below:</p>
        </div>

        <form id="feedback-form" action="feedback-submit.jsp" method="post">
            <div class="input-group">
                <label for="name">Your Name:</label>
                <input type="text" id="name" name="name" value="<%= escapeHtml(savedName) %>" placeholder="Enter your name" required>
            </div>

            <div class="input-group">
                <label for="email">Your Email:</label>
                <input type="email" id="email" name="email" value="<%= escapeHtml(savedEmail) %>" placeholder="Enter your email" required>
            </div>

            <div class="input-group">
                <label for="feedback">Your Feedback:</label>
                <textarea id="feedback" name="feedback" maxlength="1000" placeholder="Write your feedback or suggestion here" required></textarea>
                <small id="feedback-count">0 / 1000 characters</small>
            </div>

            <button type="submit" id="submitFeedbackBtn">Submit Feedback</button>
        </form>

        <div id="message" class="message" aria-live="polite"></div>
    </div>

    <script src="feedback.js?v=6"></script>
</body>
</html>
