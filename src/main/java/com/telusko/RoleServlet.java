package com.telusko;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.http.HttpSession;


public class RoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = ((String) session.getAttribute("email")).trim().toLowerCase();
        session.setAttribute("email", email);
        if (role == null || role.trim().isEmpty()) {
            response.sendRedirect("mest.jsp");
            return;
        }

        role = role.trim().toLowerCase();
        if (!"student".equals(role) && !"mentor".equals(role)) {
            response.sendRedirect("mest.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement conflict = conn.prepareStatement(
                    "SELECT 1 FROM Role WHERE LOWER(TRIM(email)) = ? AND LOWER(TRIM(role)) <> ? LIMIT 1")) {
                conflict.setString(1, email);
                conflict.setString(2, role);

                try (ResultSet conflictRs = conflict.executeQuery()) {
                    if (conflictRs.next()) {
                        response.sendRedirect("roleError.jsp");
                        return;
                    }
                }
            }

            String existingRole = null;
            try (PreparedStatement check = conn.prepareStatement(
                    "SELECT role FROM Role WHERE LOWER(TRIM(email)) = ? AND LOWER(TRIM(role)) = ? LIMIT 1")) {
                check.setString(1, email);
                check.setString(2, role);

                try (ResultSet checkRs = check.executeQuery()) {
                    if (checkRs.next()) {
                        existingRole = checkRs.getString("role");
                    }
                }
            }

            if (existingRole != null) {
                existingRole = existingRole.trim().toLowerCase();
                if (!existingRole.equals(role)) {
                        response.sendRedirect("roleError.jsp");
                        return;
                }
            } else {
                try (PreparedStatement insert = conn.prepareStatement("INSERT INTO Role (email, role) VALUES (?, ?)")) {
                    insert.setString(1, email);
                    insert.setString(2, role);
                    insert.executeUpdate();
                }
            }

            session.setAttribute("role", role);
            if ("student".equalsIgnoreCase(role)) {
                response.sendRedirect("mentorlist.jsp");
            } 
            else if ("mentor".equalsIgnoreCase(role)) {
                response.sendRedirect("mentorDashboard.jsp");
            } 
            else {
                response.sendRedirect("mest.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }
}

