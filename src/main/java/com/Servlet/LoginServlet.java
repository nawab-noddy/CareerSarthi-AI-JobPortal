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
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles POST request from login form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // basic validation
        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            HttpSession s = request.getSession();
            s.setAttribute("login-error", "Please fill both email and password.");
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConn();
            String sql = "SELECT id, name, role, password FROM users WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password");
                if (password.equals(dbPass)) { // plain-text compare for now
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String role = rs.getString("role");

                    // normalize role
                    String normalized = (role != null) ? role.replaceAll("[_\\s]", "").toLowerCase() : "seeker";

                    // 🛠 Fix: Invalidate old session if exists
                    HttpSession oldSession = request.getSession(false);
                    if (oldSession != null) {
                        oldSession.invalidate();
                    }

                    // Start new session
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", id);
                    session.setAttribute("userName", name);
                    session.setAttribute("userRole", role);

                    // Redirect based on role
                    if ("employer".equals(normalized)) {
                        response.sendRedirect("employer_dashboard.jsp");
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    return;

                } else {
                    HttpSession s = request.getSession();
                    s.setAttribute("login-error", "Invalid email or password!");
                    response.sendRedirect("login.jsp");
                    return;
                }
            } else {
                HttpSession s = request.getSession();
                s.setAttribute("login-error", "Invalid email or password!");
                response.sendRedirect("login.jsp");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession s = request.getSession();
            s.setAttribute("login-error", "Server error. Try again later.");
            response.sendRedirect("login.jsp");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
            // Do not close conn if DBConnect returns a shared connection instance
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
