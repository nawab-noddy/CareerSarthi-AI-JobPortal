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

@WebServlet("/DeleteJobServlet")
public class DeleteJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String jobIdStr = request.getParameter("jobId");

        if (jobIdStr == null) {
            response.sendRedirect("employer_job.jsp");
            return;
        }

        try {
            int jobId = Integer.parseInt(jobIdStr);
            Connection conn = DBConnect.getConn();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM jobs WHERE id = ?");
            ps.setInt(1, jobId);

            int rowsAffected = ps.executeUpdate();
            HttpSession session = request.getSession();
            if (rowsAffected > 0) {
                session.setAttribute("msg", "Job deleted successfully.");
            } else {
                session.setAttribute("msg", "Failed to delete job.");
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("employer_job.jsp");
    }
}
