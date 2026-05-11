<%@ page import="java.sql.*" %>
<%@ page import="com.telusko.DBConnection" %>
<%
    String email = (String) session.getAttribute("email");
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT mentor_email FROM mentorship_requests WHERE student_email=? AND status='accepted'");
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
%>
<h3>Your Mentors</h3>
<ul>
<%
    while(rs.next()) {
        String mentorEmail = rs.getString("mentor_email");
%>
    <li>
        <%= mentorEmail %> 
        <form action="chat.jsp" method="get" style="display:inline;">
            <input type="hidden" name="chatWith" value="<%= mentorEmail %>"/>
            <input type="submit" value="Chat"/>
        </form>
    </li>
<%
    }
    conn.close();
%>
</ul>
