package com.telusko;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String sender_email = (String) request.getSession().getAttribute("email");
        String receiver_email = request.getParameter("receiver_email");
        String message = request.getParameter("message");
        
        System.out.println("Sender: " + sender_email);
        System.out.println("Receiver: " + receiver_email);
        System.out.println("Message: " + message);
        if (sender_email == null || receiver_email == null || message == null || sender_email.isEmpty() || receiver_email.isEmpty() || message.isEmpty()) {
            out.println("Missing information. Please make sure all fields are filled.");
            return;
        }

        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
       

        try (Connection conn = DBConnection.getConnection()) {
        	PreparedStatement checkUser = conn.prepareStatement("SELECT email FROM users WHERE email = ?");
            checkUser.setString(1, receiver_email);
            ResultSet rs = checkUser.executeQuery();
            if (!rs.next()) {
                out.println("Error: Receiver does not exist in the system.");
                return;
            }
            PreparedStatement ps = conn.prepareStatement("INSERT INTO messages (sender_email, receiver_email, message,timestamp) VALUES (?, ?, ?, ?)");
            ps.setString(1, sender_email);
            ps.setString(2, receiver_email);
            ps.setString(3, message);
            ps.setTimestamp(4,currentTimestamp);
            int rows = ps.executeUpdate();
            if(rows>0) {
            response.sendRedirect("chat.jsp?chatWith="+receiver_email);
            }else {
            	out.println("Failed to send message.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error:" + e.getMessage());
        }

        
    }
}

