<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Job</title>
    <%@ include file="all_components/ALL_CDN.jsp"%>
</head>
<body class="bg-light">
<%@ include file="all_components/Navbar.jsp"%>

<div class="container mt-5">
    
    <!-- Success Message -->
    <%
        String success = request.getParameter("success");
        if ("true".equals(success)) {
    %>
        <div class="alert alert-success text-center fw-bold">
            ✅ Application Submitted Successfully!
        </div>
    <%
        } else if ("false".equals(success)) {
    %>
        <div class="alert alert-danger text-center fw-bold">
            ❌ Failed to submit application.
        </div>
    <%
        }
    %>

    <!-- Heading -->
    <div class="text-center mb-4">
        <h1 class="fw-bold">Your Details</h1>
        <p class="text-muted">Fill out the form below to apply for the job.</p>
    </div>

    <!-- Resume Form -->
    <form action="SubmitResumeServlet" method="post" class="p-4 bg-white shadow rounded">

        <!-- Hidden Job ID -->
        <%
            String jobId = request.getParameter("jobId");
            if (jobId != null) {
        %>
            <input type="hidden" name="jobId" value="<%= jobId %>">
        <%
            }
        %>

        <!-- Full Name -->
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="fullName" class="form-control" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <!-- Phone -->
        <div class="mb-3">
            <label class="form-label">Phone Number</label>
            <input type="text" name="phone" class="form-control" required>
        </div>

        <!-- Skills -->
        <div class="mb-3">
            <label class="form-label">Skills</label>
            <textarea name="skills" class="form-control" rows="3" placeholder="E.g., Java, HTML, CSS, MySQL" required></textarea>
        </div>

        <!-- Education -->
        <div class="mb-3">
            <label class="form-label">Education</label>
            <textarea name="education" class="form-control" rows="3" placeholder="E.g., B.Tech in CSE - AKTU University" required></textarea>
        </div>

        <!-- Experience -->
        <div class="mb-3">
            <label class="form-label">Work Experience</label>
            <textarea name="experience" class="form-control" rows="3" placeholder="E.g., 2 years as Java Developer"></textarea>
        </div>

        <!-- Submit -->
        <div class="text-center">
            <button type="submit" class="btn btn-primary px-4">Submit Application</button>
        </div>
    </form>
</div>

<%@ include file="all_components/Footer.jsp"%>
</body>
</html>
