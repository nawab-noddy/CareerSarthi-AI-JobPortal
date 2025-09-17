<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<%@ include file="all_components/ALL_CDN.jsp"%>

<style>
    body {
        background: linear-gradient(135deg, #74ABE2, #5563DE);
        font-family: 'Segoe UI', sans-serif;
        min-height: 100vh;
    }
    .login-card {
        background: #fff;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        animation: fadeInUp 0.8s ease;
        transition: transform 0.3s ease;
    }
    .login-card:hover {
        transform: translateY(-5px);
    }
    h3 {
        font-weight: bold;
        color: #333;
    }
    .form-control {
        border-radius: 8px;
        padding: 10px;
        border: 1px solid #ccc;
        transition: all 0.3s ease;
    }
    .form-control:focus {
        border-color: #5563DE;
        box-shadow: 0 0 8px rgba(85, 99, 222, 0.3);
    }
    .btn-dark {
        background: linear-gradient(135deg, #5563DE, #4B53D0);
        border: none;
        border-radius: 8px;
        padding: 10px;
        transition: all 0.3s ease;
    }
    .btn-dark:hover {
        background: linear-gradient(135deg, #4B53D0, #3F47B8);
        transform: scale(1.05);
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }
    a {
        color: #5563DE;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    a:hover {
        color: #333;
        text-decoration: underline;
    }
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>
<%@ include file="all_components/Navbar.jsp"%>

<div class="container">
    <div style="max-width: 400px; margin: 60px auto;">
        
        <% String invalidMsg = (String)session.getAttribute("login-failed");
           if(invalidMsg != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                <%= invalidMsg %>
            </div>
        <% session.removeAttribute("login-failed"); } %>

        <% String invalidLogin = (String)session.getAttribute("login-error");
           if(invalidLogin != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                <%= invalidLogin %>
            </div>
        <% session.removeAttribute("login-error"); } %>

        <div class="login-card">
            <h3 class="text-center mb-4">Login</h3>
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email address</label> 
                    <input type="email" name="email" class="form-control" id="email"
                           placeholder="Enter your email" required>
                </div>
                <div class="form-group mt-3">
                    <label for="password">Password</label> 
                    <input type="password" name="password" class="form-control" id="password"
                           placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-dark btn-block mt-4">Login</button>
            </form>

            <p class="mt-3 text-center">
                New user? <a href="register.jsp">Register here</a>
            </p>
        </div>
    </div>
</div>

<%@ include file="all_components/Footer.jsp"%>
</body>
</html>
