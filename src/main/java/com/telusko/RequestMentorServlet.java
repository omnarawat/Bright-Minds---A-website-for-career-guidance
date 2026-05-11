package com.telusko;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RequestMentorServlet")
	public class RequestMentorServlet extends HttpServlet {
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        jakarta.servlet.http.HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("email") == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        String student_email = (String) session.getAttribute("email");
	        String mentor_email = request.getParameter("mentor_email");

	        if (mentor_email == null || mentor_email.trim().isEmpty()) {
	            response.sendRedirect("mentorlist.jsp");
	            return;
	        }

	        try (Connection conn = DBConnection.getConnection()) {
	            try (PreparedStatement check = conn.prepareStatement(
	                    "SELECT 1 FROM mentorship_requests WHERE student_email = ? AND mentor_email = ? LIMIT 1")) {
	                check.setString(1, student_email);
	                check.setString(2, mentor_email);

	                try (ResultSet rs = check.executeQuery()) {
	                    if (!rs.next()) {
	                        try (PreparedStatement ps = conn.prepareStatement(
	                                "INSERT INTO mentorship_requests (student_email, mentor_email) VALUES (?, ?)")) {
	                            ps.setString(1, student_email);
	                            ps.setString(2, mentor_email);
	                            ps.executeUpdate();
	                        }
	                    }
	                }
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        response.sendRedirect("studentside.jsp");
	    }
	}


