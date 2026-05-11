package com.telusko;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {
 
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        email = email.trim().toLowerCase();

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE LOWER(TRIM(Email)) = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }

                HttpSession session = request.getSession(true);
                String firstName = rs.getString("Firstname");
                String lastName = rs.getString("Lastname");
                String fullName = ((firstName == null ? "" : firstName.trim()) + " " +
                        (lastName == null ? "" : lastName.trim())).trim();

                session.setAttribute("email", email);
                session.setAttribute("name", fullName);
                session.setMaxInactiveInterval(30 * 60);

                Cookie userCookie = new Cookie("loggedInUser", email);
                userCookie.setHttpOnly(true);
                userCookie.setMaxAge(30 * 60);
                userCookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
                response.addCookie(userCookie);

                response.sendRedirect("mest.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }
}
