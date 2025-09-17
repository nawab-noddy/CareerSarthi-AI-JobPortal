package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitResumeServlet")
public class SubmitResumeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Logged-in user ID
        int userId = (Integer) session.getAttribute("userId");

        // Job ID from request
        String jobIdStr = request.getParameter("jobId");
        if (jobIdStr == null) {
            response.sendRedirect("apply_job.jsp?error=missingJobId");
            return;
        }
        int jobId = Integer.parseInt(jobIdStr);

        // Form inputs
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String skills = request.getParameter("skills");
        String education = request.getParameter("education");
        String experience = request.getParameter("experience");

        Connection conn = null;
        PreparedStatement psResume = null;
        PreparedStatement psApplied = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/job_portal?allowPublicKeyRetrieval=true&useSSL=false",
                    "root", "");

            // Insert into resumes table
            String sqlResume = "INSERT INTO resumes(job_id, user_id, full_name, email, phone, skills, education, experience, applied_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            psResume = conn.prepareStatement(sqlResume);
            psResume.setInt(1, jobId);
            psResume.setInt(2, userId);
            psResume.setString(3, fullName);
            psResume.setString(4, email);
            psResume.setString(5, phone);
            psResume.setString(6, skills);
            psResume.setString(7, education);
            psResume.setString(8, experience);
            psResume.executeUpdate();

            // Insert into applied_jobs table (user_id + job_id)
            String sqlApplied = "INSERT INTO applied_jobs(user_id, job_id, applied_at) VALUES (?, ?, NOW())";
            psApplied = conn.prepareStatement(sqlApplied);
            psApplied.setInt(1, userId);
            psApplied.setInt(2, jobId);
            psApplied.executeUpdate();

            // Redirect with success
            response.sendRedirect("apply_job.jsp?jobId=" + jobId + "&success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("apply_job.jsp?jobId=" + jobId + "&success=false");
        } finally {
            try { if (psResume != null) psResume.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (psApplied != null) psApplied.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
