<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="com.telusko.DBConnection" %>
<%!
    private String clean(String value) {
        return value == null ? "" : value.trim();
    }

    private String jsonEscape(String value) {
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "\\r")
                .replace("\n", "\\n");
    }

    private String userNameFromEmail(Connection connection, String email) throws SQLException {
        if (email.isEmpty()) {
            return "";
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT Firstname, Lastname FROM users WHERE LOWER(TRIM(Email)) = LOWER(TRIM(?)) LIMIT 1")) {
            preparedStatement.setString(1, email);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return (clean(resultSet.getString("Firstname")) + " " +
                            clean(resultSet.getString("Lastname"))).trim();
                }
            }
        }

        return email.contains("@") ? email.substring(0, email.indexOf("@")) : "";
    }

    private String cookieValue(Cookie[] cookies, String cookieName) {
        if (cookies == null) {
            return "";
        }

        for (Cookie cookie : cookies) {
            if (cookieName.equals(cookie.getName())) {
                return clean(cookie.getValue());
            }
        }

        return "";
    }
%>
<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String name = clean(request.getParameter("name"));
    String email = clean(request.getParameter("email"));
    String feedback = clean(request.getParameter("feedback"));
    String sessionEmail = clean(session.getAttribute("email") == null ? "" : session.getAttribute("email").toString());
    String sessionName = clean(session.getAttribute("name") == null ? "" : session.getAttribute("name").toString());

    if (sessionEmail.isEmpty()) {
        sessionEmail = cookieValue(request.getCookies(), "loggedInUser");
    }

    if (email.isEmpty()) {
        email = sessionEmail;
    }

    if (feedback.isEmpty()) {
        response.setStatus(400);
        out.print("{\"success\":false,\"message\":\"Please write your feedback message.\"}");
        return;
    }

    String createTableSql = "CREATE TABLE IF NOT EXISTS feedback (" +
            "id INT AUTO_INCREMENT PRIMARY KEY, " +
            "name VARCHAR(100) NOT NULL, " +
            "email VARCHAR(150) NOT NULL, " +
            "message TEXT NOT NULL, " +
            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
            ")";

    String insertSql = "INSERT INTO feedback (name, email, message) VALUES (?, ?, ?)";

    try (Connection connection = DBConnection.getConnection()) {
        if (connection == null) {
            throw new SQLException("Database connection is not available.");
        }

        if (name.isEmpty()) {
            name = sessionName;
        }

        if (name.isEmpty()) {
            name = userNameFromEmail(connection, email);
        }

        if (name.isEmpty()) {
            response.setStatus(400);
            out.print("{\"success\":false,\"message\":\"Please enter your name.\"}");
            return;
        }

        if (email.isEmpty()) {
            response.setStatus(400);
            out.print("{\"success\":false,\"message\":\"Please enter your email.\"}");
            return;
        }

        try (Statement statement = connection.createStatement()) {
            statement.execute(createTableSql);
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSql)) {
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, feedback);
            preparedStatement.executeUpdate();
        }

        out.print("{\"success\":true,\"message\":\"Thank you! Your feedback has been saved.\"}");
    } catch (SQLException exception) {
        exception.printStackTrace();
        response.setStatus(500);
        out.print("{\"success\":false,\"message\":\"" + jsonEscape("Could not save feedback right now. Please try again.") + "\"}");
    }
%>
