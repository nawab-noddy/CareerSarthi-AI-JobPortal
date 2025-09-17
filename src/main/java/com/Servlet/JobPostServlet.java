package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/JobPostServlet")
public class JobPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = session.getAttribute("userRole").toString();
        if (!"employer".equalsIgnoreCase(role)) {
            response.sendRedirect("employer_dashboard.jsp?error=1");
            return;
        }

        // form fields
        String title = request.getParameter("title");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String experience = request.getParameter("experience");
        String description = request.getParameter("description");
        String salary = request.getParameter("salary");

        // get employer ID from session (assuming stored at login)
        Integer employerId = (Integer) session.getAttribute("userId");

        try (Connection conn = DBConnect.getConn()) {
            String sql = "INSERT INTO jobs (title, company, location, experience, description, post_date, employer_id, salary) "
                       + "VALUES (?, ?, ?, ?, ?, CURRENT_DATE, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, company);
            ps.setString(3, location);
            ps.setString(4, experience);
            ps.setString(5, description);
            ps.setInt(6, employerId);
            ps.setString(7, salary);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("employer_dashboard.jsp?success=1");
            } else {
                response.sendRedirect("employer_dashboard.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("employer_dashboard.jsp?error=1");
        }
    }
}
