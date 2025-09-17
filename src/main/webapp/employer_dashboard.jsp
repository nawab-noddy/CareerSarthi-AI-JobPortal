<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employer Dashboard</title>
<%@ include file="all_components/ALL_CDN.jsp"%>

<style>
body {
	background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
	animation: fadeIn 0.8s ease-in-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(15px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.dashboard-container {
	background: white;
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0px 6px 18px rgba(0, 0, 0, 0.1);
	animation: slideUp 0.7s ease-in-out;
}

@
keyframes slideUp {from { transform:translateY(20px);
	opacity: 0;
}

to {
	transform: translateY(0);
	opacity: 1;
}

}
.form-control {
	border: 1px solid #ddd;
	transition: 0.3s ease;
}

.form-control:focus {
	border-color: #6c63ff;
	box-shadow: 0 0 8px rgba(108, 99, 255, 0.5);
}

button.btn-primary {
	background: linear-gradient(90deg, #6c63ff, #836fff);
	border: none;
	transition: 0.3s ease;
}

button.btn-primary:hover {
	transform: scale(1.05);
	background: linear-gradient(90deg, #5a54e0, #6c63ff);
	box-shadow: 0 4px 15px rgba(108, 99, 255, 0.4);
}

h3, p {
	animation: fadeIn 1s ease;
}

.alert {
	animation: fadeIn 0.5s ease-in-out;
}
</style>
</head>
<body>
	<%@ include file="all_components/Navbar.jsp"%>

	<div class="container mt-4" style="max-width: 720px;">
		<%
		HttpSession sess = request.getSession(false);
		if (sess == null || sess.getAttribute("userRole") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		String emprole = sess.getAttribute("userRole").toString();
		String normalized = emprole.replaceAll("[_\\s]", "").toLowerCase();

		if (!"employer".equals(normalized)) {
		%>
		<div class="alert alert-danger mt-3">Access denied. Only
			employers can access this page.</div>
		<%
		return;
		}
		String employerName = (String) sess.getAttribute("userName");
		%>

		<div class="dashboard-container">
			<h3 class="mb-3">Employer Panel — Post a Job</h3>
			<p class="text-muted">
				Welcome, <strong><%=employerName != null ? employerName : "Employer"%></strong>!
			</p>

			<%-- show success/fail messages if present --%>
			<%
			String success = request.getParameter("success");
			String error = request.getParameter("error");
			if ("1".equals(success)) {
			%>
			<div class="alert alert-success">✅ Job posted successfully.</div>
			<%
			} else if ("1".equals(error)) {
			%>
			<div class="alert alert-danger">❌ Failed to post job. Try
				again.</div>
			<%
			}
			%>

			<form action="JobPostServlet" method="post">
				<div class="form-group">
					<label for="title">Job Title</label> <input type="text"
						name="title" id="title" class="form-control" required>
				</div>

				<div class="form-group">
					<label for="company">Company Name</label> <input type="text"
						name="company" id="company" class="form-control" required>
				</div>

				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="location">Location</label> <input type="text"
							name="location" id="location" class="form-control" required>
					</div>
					<div class="form-group col-md-6">
						<label for="experience">Experience</label> <input type="text"
							name="experience" id="experience" class="form-control"
							placeholder="e.g. 1-3 years">
					</div>
					<div class="form-group">
						<label for="salary">Salary</label> <input type="text"
							name="salary" id="salary" class="form-control"
							placeholder="e.g. 50,000 - 70,000">
					</div>
				</div>

				<div class="form-group">
					<label for="description">Job Description</label>
					<textarea name="description" id="description" class="form-control"
						rows="5" required></textarea>
				</div>


				<button type="submit" class="btn btn-primary btn-block">🚀
					Post Job</button>
			</form>
		</div>
	</div>

	<%@ include file="all_components/Footer.jsp"%>

</body>
</html>
