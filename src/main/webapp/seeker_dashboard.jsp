<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Seeker Dashboard</title>
<%@ include file="all_components/ALL_CDN.jsp" %>
<style>
body {
    background: #f5f7fa;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
.card {
    background: #fff;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    margin-top: 30px;
    transition: 0.3s ease-in-out;
}
.card:hover {
    transform: scale(1.02);
    box-shadow: 0 6px 16px rgba(0,0,0,0.15);
}
.profile-box {
    border: 2px solid #007bff;
    border-radius: 12px;
    padding: 25px;
    min-width: 300px;
    display: inline-block;
}
.profile-box h4 {
    margin-bottom: 20px;
    color: #333;
}
.profile-box span {
    color: #007bff;
    font-weight: bold;
}
.profile-details p {
    font-size: 15px;
    margin: 10px 0;
}
.profile-details i {
    color: #007bff;
    margin-right: 8px;
}
</style>
</head>
<body>
<%@ include file="all_components/Navbar.jsp" %>

<div class="container mt-4">
    <%
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = "";
        String email = "";
        String userRole = "";

        try (Connection conn = DBConnect.getConn()) {
            PreparedStatement ps = conn.prepareStatement("SELECT name, email, role FROM users WHERE id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userName = rs.getString("name");
                email = rs.getString("email");
                userRole = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="card text-center">
        <div class="profile-box" style="">
            <h4>👋 Welcome, <span><%= userName %></span></h4>
            <div class="profile-details" style="text-align:center;">
                <p><i class="bi bi-person-circle"></i> <strong>Full Name:</strong> <%= userName %></p>
                <p><i class="bi bi-envelope"></i> <strong>Email:</strong> <%= email %></p>
                <p><i class="bi bi-person-badge"></i> <strong>Role:</strong> <%= userRole %></p>
            </div>
        </div>
    </div>
</div>

<%@ include file="all_components/Footer.jsp" %>
</body>
</html>
