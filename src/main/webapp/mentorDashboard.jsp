<%@ page import="java.sql.*, com.telusko.DBConnection" %>
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
    if(session == null || session.getAttribute("email") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String mentorEmail = (String) session.getAttribute("email");
    Connection conn = DBConnection.getConnection();
    PreparedStatement requestPs = conn.prepareStatement(
        "SELECT * FROM mentorship_requests WHERE mentor_email = ? AND status = 'pending'"
    );
    requestPs.setString(1, mentorEmail);
    ResultSet requestRs = requestPs.executeQuery();

    PreparedStatement chatPs = conn.prepareStatement(
        "SELECT DISTINCT student_email FROM mentorship_requests " +
        "WHERE mentor_email = ? AND status = 'accepted' " +
        "ORDER BY student_email"
    );
    chatPs.setString(1, mentorEmail);
    ResultSet chatRs = chatPs.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mentor Dashboard</title>


<style>
body {
    font-family: Arial;
    background: #f4f6f9;
}

.container {
    width: min(900px, 92%);
    margin: auto;
    margin-top: 40px;
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 5px 15px rgba(0,0,0,0.1);
}

h2 {
    text-align: center;
}

.top-bar {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 12px;
}

.section {
    margin-top: 26px;
}

.section:first-of-type {
    margin-top: 0;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #4CAF50;
    color: white;
    padding: 10px;
}

td {
    padding: 10px;
    text-align: center;
}

tr:hover {
    background: #f1f1f1;
}

button {
    padding: 6px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin: 2px;
}

.accept {
    background: green;
    color: white;
}

.reject {
    background: red;
    color: white;
}

.chat-list {
    display: grid;
    gap: 10px;
    margin: 14px 0 0;
    padding: 0;
    list-style: none;
}

.chat-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background: #fafafa;
}

.chat-email {
    overflow-wrap: anywhere;
    font-weight: 600;
}

.chat-button {
    display: inline-block;
    padding: 8px 14px;
    border-radius: 6px;
    background: #1976d2;
    color: white;
    text-decoration: none;
    font-weight: 600;
    white-space: nowrap;
}

.empty-message {
    text-align: center;
    margin-top: 15px;
    color: #666;
}
</style>

</head>

<body>

<div class="container">
<div class="top-bar"><a href="Logout">Logout</a></div>

<section class="section">
<h2>Mentorship Requests</h2>
<table>
    <tr>
        <th>Student Email</th>
        <th>Action</th>
    </tr>

    <% 
    boolean hasData = false;
    while (requestRs.next()) { 
        hasData = true;
        String studentEmail = requestRs.getString("student_email");
    %>
    <tr>
        <td><%= escapeHtml(studentEmail) %></td>
        <td>
            <form action="HandleRequestServlet" method="post" style="display:inline;">
                <input type="hidden" name="student_email" value="<%= escapeHtml(studentEmail) %>">
                <input type="hidden" name="status" value="accept">
                <button class="accept">Accept</button>
            </form>

            <form action="HandleRequestServlet" method="post" style="display:inline;">
                <input type="hidden" name="student_email" value="<%= escapeHtml(studentEmail) %>">
                <input type="hidden" name="status" value="reject">
                <button class="reject">Reject</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

<% if(!hasData){ %>
    <p class="empty-message">No pending requests</p>
<% } %>
</section>

<section class="section">
<h2>Chat List</h2>
<ul class="chat-list">
    <%
    boolean hasChats = false;
    while (chatRs.next()) {
        hasChats = true;
        String studentEmail = chatRs.getString("student_email");
    %>
    <li class="chat-item">
        <span class="chat-email"><%= escapeHtml(studentEmail) %></span>
        <a class="chat-button" href="chat.jsp?chatWith=<%= java.net.URLEncoder.encode(studentEmail, java.nio.charset.StandardCharsets.UTF_8) %>">Open Chat</a>
    </li>
    <%
    }
    %>
</ul>

<% if(!hasChats){ %>
    <p class="empty-message">No accepted students yet</p>
<% } %>
</section>

</div>


<script>
document.querySelectorAll("button").forEach(btn => {
    btn.addEventListener("click", function() {
        this.closest("tr").style.opacity = "0.5";
    });
});
</script>

</body>
</html>

<%
chatRs.close();
chatPs.close();
requestRs.close();
requestPs.close();
conn.close();
%>
