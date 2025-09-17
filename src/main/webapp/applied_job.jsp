<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Applied Jobs</title>
<%@ include file="all_components/ALL_CDN.jsp"%>
</head>
<body>
<%@ include file="all_components/Navbar.jsp"%>

<div class="container mt-4">
    <h3>My Applied Jobs</h3>
    <hr>

    <%
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnect.getConn();
            String sql = "SELECT j.title, j.company, j.location, j.salary, r.applied_date " +
                    "FROM resumes r " +
                    "JOIN jobs j ON r.job_id = j.id " +
                    "WHERE r.user_id = ? " +   // yaha seeker_id/user_id hona chahiye
                    "ORDER BY r.applied_date DESC";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            boolean hasData = false;
    %>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Title</th>
                        <th>Company</th>
                        <th>Location</th>
                        <th>Salary</th>
                        <th>Applied Date</th>
                    </tr>
                </thead>
                <tbody>
    <%
            while (rs.next()) {
                hasData = true;
    %>
                <tr>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("company") %></td>
                    <td><%= rs.getString("location") %></td>
                    <td><%= rs.getString("salary") %></td>
                    <td><%= rs.getTimestamp("applied_date") %></td>
                </tr>
    <%
            }
            if (!hasData) {
    %>
                <tr>
                    <td colspan="5" class="text-center text-muted">You haven't applied to any jobs yet.</td>
                </tr>
    <%
            }
    %>
                </tbody>
            </table>
    <%
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error loading applied jobs.</div>");
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
            try { if (conn != null) conn.close(); } catch (Exception ex) {}
        }
    %>
</div>

<%@ include file="all_components/Footer.jsp"%>
</body>
</html>
