<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.db.DBConnect"%>
<%@ page session="true"%>

<%
    Integer employerId = (Integer) session.getAttribute("userId");
    if (employerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = DBConnect.getConn();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs WHERE employer_id = ?");
    ps.setInt(1, employerId);
    ResultSet rs = ps.executeQuery();

    // Agar koi job ke candidates dekhna hai
    String selectedJobId = request.getParameter("jobId");
    ResultSet rsCandidates = null;
    if (selectedJobId != null) {
        PreparedStatement ps2 = conn.prepareStatement(
            "SELECT * FROM resumes WHERE job_id = ?"
        );
        ps2.setInt(1, Integer.parseInt(selectedJobId));
        rsCandidates = ps2.executeQuery();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Posted Jobs</title>
<%@ include file="all_components/ALL_CDN.jsp"%>
<style>
body {
	background: #f9f9f9;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h2 {
	color: #333;
	font-weight: bold;
	animation: fadeIn 1s ease-in-out;
}

table {
	background: white;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.1);
	animation: fadeInUp 0.8s ease-in-out;
}

thead {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
}

tbody tr {
	transition: all 0.3s ease-in-out;
}

tbody tr:hover {
	background-color: #f0f8ff;
	transform: scale(1.01);
}

.btn-danger {
	background-color: #ff4d4d;
	border: none;
	transition: all 0.3s ease;
}

.btn-danger:hover {
	background-color: #cc0000;
	transform: scale(1.1);
	box-shadow: 0px 3px 6px rgba(255, 0, 0, 0.3);
}

.btn-info {
	background-color: #17a2b8;
	color: white;
}

.btn-info:hover {
	background-color: #11707f;
	transform: scale(1.05);
}
</style>
</head>
<body>

	<%@ include file="all_components/Navbar.jsp"%>

	<div class="container mt-5">
		<h2 class="mb-4 text-center">My Posted Jobs</h2>

		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>Title</th>
					<th>Location</th>
					<th>Experience</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
                    while (rs.next()) {
                        int jobId = rs.getInt("id");
                %>
				<tr>
					<td><%= rs.getString("title") %></td>
					<td><%= rs.getString("location") %></td>
					<td><%= rs.getString("experience") %></td>
					<td>
						<!-- Delete Job -->
						<form action="DeleteJobServlet" method="post"
							style="display: inline;">
							<input type="hidden" name="jobId" value="<%= jobId %>"> <input
								type="submit" class="btn btn-danger btn-sm" value="Delete"
								onclick="return confirm('Are you sure you want to delete this job?');">
						</form> <!-- View Candidates -->
						<form action="employer_job.jsp" method="get"
							style="display: inline;">
							<input type="hidden" name="jobId" value="<%= jobId %>"> <input
								type="submit" class="btn btn-info btn-sm"
								value="View Candidates">
						</form>
					</td>
				</tr>
				<%
                    }
                    rs.close();
                    ps.close();
                %>
			</tbody>
		</table>
	</div>

	<!-- Candidates Table -->
	<div class="container mt-5">
		<%
            if (rsCandidates != null) {
        %>
		<h3 class="mb-4 text-center">Candidates Applied</h3>
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>Full Name</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Skills</th>
					<th>Education</th>
					<th>Experience</th>
					<th>Applied Date</th>
				</tr>
			</thead>
			<tbody>
				<%
                        boolean hasCandidates = false;
                        while (rsCandidates.next()) {
                            hasCandidates = true;
                    %>
				<tr>
					<td><%= rsCandidates.getString("full_name") %></td>
					<td><%= rsCandidates.getString("email") %></td>
					<td><%= rsCandidates.getString("phone") %></td>
					<td><%= rsCandidates.getString("skills") %></td>
					<td><%= rsCandidates.getString("education") %></td>
					<td><%= rsCandidates.getString("experience") %></td>
					<td><%= rsCandidates.getTimestamp("applied_date") %></td>
				</tr>
				<%
                        }
                        if (!hasCandidates) {
                    %>
				<tr>
					<td colspan="7" class="text-center">No candidates applied yet.</td>
				</tr>
				<%
                        }
                        rsCandidates.close();
                    %>
			</tbody>
		</table>
		<%
            }
        %>
	</div>

	<%@ include file="all_components/Footer.jsp"%>
</body>
</html>
