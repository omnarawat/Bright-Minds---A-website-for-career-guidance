package com.telusko;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/HandleRequestServlet")
public class HandleRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentEmail = request.getParameter("student_email");
        String status = request.getParameter("status");
        String mentorEmail = (String) request.getSession().getAttribute("email"); // Fix: should be "email" not "mentor_email"

        if (mentorEmail == null || studentEmail == null || status == null) {
            response.sendRedirect("error.jsp");
            return;
        }
   
        if ("accept".equalsIgnoreCase(status)) {
            status = "accepted";
        } else if ("reject".equalsIgnoreCase(status)) {
            status = "rejected";
        } else {
            status = "pending";
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE mentorship_requests SET status=? WHERE student_email=? AND mentor_email=?"
            );
            ps.setString(1, status);
            ps.setString(2, studentEmail);
            ps.setString(3, mentorEmail);

            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                if ("accepted".equals(status)) {
                    response.sendRedirect("chat.jsp?chatWith=" + studentEmail);
                } 
                else if ("rejected".equals(status)) {
                    response.sendRedirect("mentorReject.jsp?student_email=" + URLEncoder.encode(studentEmail, StandardCharsets.UTF_8));
                }
                else {
                    response.sendRedirect("mentor_dashboard.jsp"); 
                }
            } else {
                response.getWriter().println("No matching record found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

