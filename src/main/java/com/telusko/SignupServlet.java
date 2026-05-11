package com.telusko;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/Signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fname = request.getParameter("fName");
        String lname = request.getParameter("lName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        email = email.trim().toLowerCase();

        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement check = conn.prepareStatement("SELECT 1 FROM users WHERE LOWER(email) = LOWER(?) LIMIT 1")) {
                check.setString(1, email);

                try (ResultSet rs = check.executeQuery()) {
                    if (rs.next()) {
                        response.sendRedirect("login.jsp");
                        return;
                    }
                }
            }

            int rows;
            String query = "INSERT INTO users (Firstname, Lastname, Email, password) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, email);
                ps.setString(4, password);
                rows = ps.executeUpdate();
            }

            if (rows > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }
}
