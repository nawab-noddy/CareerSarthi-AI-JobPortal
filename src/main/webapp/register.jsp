<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<%@ include file="all_components/ALL_CDN.jsp" %>
<style>
    /* Background gradient animation */
    body {
        background: linear-gradient(120deg, #74ebd5, #ACB6E5);
        background-size: 200% 200%;
        animation: gradientMove 6s ease infinite;
    }
    @keyframes gradientMove {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* Center form container */
    .register-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 25px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        animation: fadeInUp 0.8s ease;
    }
    .register-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 35px rgba(0, 0, 0, 0.3);
    }
    @keyframes fadeInUp {
        0% { opacity: 0; transform: translateY(20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    /* Input focus glow */
    .form-control:focus {
        border-color: #74ebd5;
        box-shadow: 0 0 8px rgba(116, 235, 213, 0.7);
    }

    /* Button animation */
    .btn-custom {
        background: linear-gradient(90deg, #74ebd5, #ACB6E5);
        border: none;
        color: white;
        font-weight: bold;
        transition: transform 0.2s ease, background 0.3s ease;
    }
    .btn-custom:hover {
        transform: scale(1.05);
        background: linear-gradient(90deg, #ACB6E5, #74ebd5);
    }
</style>
</head>
<body>

<%@ include file="all_components/Navbar.jsp" %>

<div class="d-flex justify-content-center align-items-center" style="min-height: 90vh;">
    <div class="register-card" style="max-width: 420px; width: 100%;">
        <h3 class="text-center mb-4">Create Account</h3>

        <%-- Messages --%>
        <%
            String err = request.getParameter("error");
            String success = request.getParameter("success");
            if ("exists".equals(err)) {
        %>
            <div class="alert alert-danger">Email already registered. Try login.</div>
        <% } else if ("empty".equals(err)) { %>
            <div class="alert alert-warning">Please fill all fields.</div>
        <% } else if ("failed".equals(err)) { %>
            <div class="alert alert-danger">Registration failed. Try again.</div>
        <% } else if ("exception".equals(err)) { %>
            <div class="alert alert-danger">Server error. Check console.</div>
        <% } else if ("registered".equals(success)) { %>
            <div class="alert alert-success">Registered successfully. Please login.</div>
        <% } %>

        <form action="RegisterServlet" method="post">
            <div class="form-group mb-3">
                <label for="name">Full Name</label>
                <input type="text" name="name" class="form-control" id="name"
                       placeholder="Enter your full name" required>
            </div>

            <div class="form-group mb-3">
                <label for="email">Email address</label>
                <input type="email" name="email" class="form-control" id="email"
                       placeholder="Enter your email" required>
            </div>

            <div class="form-group mb-3">
                <label for="password">Password</label>
                <input type="password" name="password" class="form-control" id="password"
                       placeholder="Enter your password" required>
            </div>

            <div class="form-group mb-4">
                <label for="role">I am a</label>
                <select name="role" id="role" class="form-control" required>
                    <option value="">Select Role</option>
                    <option value="job_seeker">Job Seeker</option>
                    <option value="employer">Employer</option>
                </select>
            </div>

            <button type="submit" class="btn btn-custom btn-block w-100 py-2">Register</button>
        </form>

        <p class="mt-3 text-center">
            Already have an account? <a href="login.jsp">Login here</a>
        </p>
    </div>
</div>

<%@ include file="all_components/Footer.jsp" %>
</body>
</html>
