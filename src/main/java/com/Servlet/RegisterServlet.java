package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles POST request from register form
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Basic validation (you can expand)
        if (name == null || email == null || password == null || role == null ||
            name.isBlank() || email.isBlank() || password.isBlank() || role.isBlank()) {
            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        try {
            Connection conn = DBConnect.getConn();

            // 1) Check if email already exists
            String checkSql = "SELECT id FROM users WHERE email = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                // Email already registered
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            // 2) Insert new user into users table
            String insertSql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement insertPs = conn.prepareStatement(insertSql);
            insertPs.setString(1, name);
            insertPs.setString(2, email);
            insertPs.setString(3, password); // TODO: replace with hashed password later
            insertPs.setString(4, role);

            int rows = insertPs.executeUpdate();
            if (rows > 0) {
                // Registered successfully -> redirect to login with success param
                response.sendRedirect("login.jsp?success=registered");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=exception");
        }
    }
}
