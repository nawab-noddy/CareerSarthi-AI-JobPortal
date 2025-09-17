<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%
    HttpSession _session = request.getSession(false);

    String loggedName = null;
    String role = null;
    if (_session != null) {
        Object v;
        v = _session.getAttribute("userName");
        if (v == null) v = _session.getAttribute("userD");
        if (v == null) v = _session.getAttribute("userObj");
        if (v == null) v = _session.getAttribute("name");
        if (v != null) loggedName = v.toString();

        Object r = _session.getAttribute("userRole");
        if (r == null) r = _session.getAttribute("role");
        if (r != null) role = r.toString();
    }
%>





<!-- Bootstrap CSS & Icons -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
/* Smooth Gradient Background */
.navbar-custom {
	background: linear-gradient(90deg, #4e54c8, #8f94fb);
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
	animation: fadeInNav 0.8s ease;
}

@
keyframes fadeInNav {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Brand Style */
.navbar-brand {
	font-weight: bold;
	font-size: 1.4rem;
	display: flex;
	align-items: center;
	gap: 6px;
	color: #fff !important;
	transition: transform 0.3s ease, text-shadow 0.3s ease;
}

.navbar-brand:hover {
	transform: scale(1.08);
	text-shadow: 0px 0px 10px rgba(255, 255, 255, 0.8);
}

/* Navbar Links */
.navbar-nav .nav-link {
	color: #f8f9fa !important;
	font-weight: 500;
	position: relative;
	padding: 8px 15px;
	transition: all 0.3s ease;
}

.navbar-nav .nav-link:hover {
	color: #ffeb3b !important;
	transform: translateY(-3px);
}

.navbar-nav .nav-link i {
	transition: transform 0.3s ease;
}

.navbar-nav .nav-link:hover i {
	transform: rotate(12deg) scale(1.1);
}

/* Active Link Animation */
.navbar-nav .nav-item.active .nav-link::after {
	content: '';
	position: absolute;
	left: 0;
	bottom: 2px;
	width: 0;
	height: 2px;
	background-color: #ffeb3b;
	animation: linkUnderline 0.4s ease forwards;
}

@
keyframes linkUnderline {to { width:100%;
	
}

}

/* Buttons Hover */
.btn {
	transition: all 0.3s ease;
}

.btn:hover {
	transform: translateY(-3px) scale(1.02);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.navbar-text strong {
	color: #ffeb3b;
}
/* Register Button Modern Style */
.btn-register {
	background: linear-gradient(45deg, #00c853, #b2ff59);
	color: white;
	font-weight: 600;
	border: none;
	border-radius: 30px;
	padding: 6px 18px;
	transition: all 0.3s ease;
}

.btn-register:hover {
	background: linear-gradient(45deg, #00e676, #76ff03);
	box-shadow: 0px 4px 15px rgba(0, 200, 83, 0.4);
	transform: translateY(-2px) scale(1.05);
}

/* Login Button Modern Style */
.btn-login {
	border: 2px solid white;
	color: white;
	font-weight: 600;
	border-radius: 30px;
	padding: 6px 18px;
	background: transparent;
	transition: all 0.3s ease;
}

.btn-login:hover {
	background: white;
	color: black;
	transform: translateY(-2px) scale(1.05);
	box-shadow: 0px 4px 15px rgba(255, 255, 255, 0.4);
}
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
	<a class="navbar-brand" href="index.jsp"> <i
		class="bi bi-briefcase-fill"></i> Job Portal
	</a>

	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNav" aria-controls="navbarNav"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarNav">
		<!-- Left Links -->
		<ul class="navbar-nav mr-auto">
			<li
				class="nav-item <%= (request.getRequestURI().endsWith("index.jsp") ? "active" : "") %>">
				<a class="nav-link" href="home.jsp"><i class="bi bi-house-door"></i>
					Home</a>
			</li>

			<%
        if ("employer".equalsIgnoreCase(role)) {
      %>
			<li class="nav-item"><a class="nav-link" href="employer_job.jsp"><i
					class="bi bi-clipboard-plus"></i> My Posted Jobs</a></li>
			<%
        } else if ("job_seeker".equalsIgnoreCase(role)) {
      %>
			<li class="nav-item"><a class="nav-link" href="applied_job.jsp"><i
					class="bi bi-briefcase-check"></i> Applied Jobs</a></li>
			<%
        } else {
      %>
			<li class="nav-item"><a class="nav-link" href="jobs.jsp"><i
					class="bi bi-search"></i> Jobs</a></li>
			<%
        }
      %>

			<li class="nav-item"><a class="nav-link" href="#"><i
					class="bi bi-buildings"></i> Companies</a></li>
		</ul>

		<!-- Right Buttons -->
		<div class="form-inline">
			<%
        if (loggedName != null) {
      %>
			<div class="navbar-text mr-3 text-light">
				<i class="bi bi-person-circle"></i> &nbsp;<strong><%= loggedName %></strong>
			</div>

			<%
                if ("employer".equalsIgnoreCase(role)) {
            %>
			<a href="employer_dashboard.jsp" class="btn btn-warning mr-2"> <i
				class="bi bi-speedometer2"></i> Dashboard
			</a>
			<%
                } else {
            %>
			<a href="seeker_dashboard.jsp" class="btn btn-warning mr-2"> <i
				class="bi bi-speedometer2"></i> My Dashboard
			</a>
			<%
                }
            %>

			<a href="LogoutServlet" class="btn btn-danger"> <i
				class="bi bi-box-arrow-right"></i> Logout
			</a>

			<%
        } else {
      %>
			<a href="register.jsp" class="btn btn-register mr-2"> <i
				class="bi bi-person-plus"></i> Register
			</a> <a href="login.jsp" class="btn btn-login"> <i
				class="bi bi-box-arrow-in-right"></i> Login
			</a>

			<%
        }
      %>
		</div>
	</div>
</nav>
