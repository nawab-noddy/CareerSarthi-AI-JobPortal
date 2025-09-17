<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<%@ include file="all_components/ALL_CDN.jsp"%>

<style>
/* ===== HERO SECTION ===== */
.hero-section {
    background: linear-gradient(135deg, #f0f4ff, #ffffff);
    text-align: center;
    padding: 60px 20px;
    animation: fadeIn 1s ease-in-out;
}
.hero-section h1 {
    font-weight: bold;
    font-size: 2.8rem;
    color: #222;
    animation: slideDown 1s ease-in-out;
}
.hero-section p {
    color: #666;
    font-size: 1.2rem;
}

/* ===== SEARCH BAR ===== */
.search-bar {
    background: white;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    padding: 10px;
    margin-top: 30px;
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
    transition: all 0.3s ease-in-out;
}
.search-bar:hover {
    box-shadow: 0 6px 25px rgba(0,0,0,0.12);
    transform: translateY(-2px);
}
.search-bar input, .search-bar select {
    border: none;
    outline: none;
    padding: 10px 15px;
    flex: 1;
    font-size: 14px;
    color: #555;
    background: transparent;
}
.search-bar button {
    background: linear-gradient(135deg, #2962ff, #4f83ff);
    color: white;
    border: none;
    padding: 10px 25px;
    border-radius: 50px;
    font-weight: bold;
    transition: all 0.3s ease-in-out;
}
.search-bar button:hover {
    background: linear-gradient(135deg, #4f83ff, #2962ff);
    transform: scale(1.05);
}

/* ===== JOB CARDS ===== */
.job-card {
    border-radius: 10px;
    overflow: hidden;
    background: white;
    box-shadow: 0px 2px 8px rgba(0,0,0,0.08);
    transition: all 0.3s ease-in-out;
}
.job-card:hover {
    transform: translateY(-5px);
    box-shadow: 0px 6px 20px rgba(0,0,0,0.12);
}
.job-card .btn {
    transition: transform 0.3s ease;
}
.job-card .btn:hover {
    transform: scale(1.08);
}

/* ===== ANIMATIONS ===== */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}
@keyframes slideDown {
    from { transform: translateY(-20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}
</style>

</head>
<body>
<%@ include file="all_components/Navbar.jsp"%>

<!-- HERO SECTION -->
<section class="hero-section">
    <h1>Find Your Dream Job Now 🚀</h1>
    <p>5 lakh+ jobs for you to explore</p>

    <!-- SEARCH BAR -->
    <form action="searchJobs.jsp" method="get" class="search-bar">
        <input type="text" name="skills" placeholder="Enter skills / designations / companies" required>
        <select name="experience">
            <option value="">Select experience</option>
            <option value="0-1">0-1 years</option>
            <option value="1-3">1-3 years</option>
            <option value="3-5">3-5 years</option>
            <option value="5+">5+ years</option>
        </select>
        <input type="text" name="location" placeholder="Enter location">
        <button type="submit">Search</button>
    </form>
</section>

<%@ page import="java.sql.*, com.db.DBConnect" %>

<!-- JOB LISTINGS -->
<section style="padding: 50px 20px; background: #f8f9fa;">
    <div class="container">
        <h3 class="text-center mb-4">✨ Latest Job Listings</h3>

        <%
            Connection conn = DBConnect.getConn();
            String sql = "SELECT * FROM jobs ORDER BY post_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
        %>
        <div class="card job-card mb-3">
            <div class="card-body d-flex justify-content-between align-items-start flex-wrap">
                <div style="flex: 1 1 70%;">
                    <h5 class="card-title text-primary"><%= rs.getString("title") %></h5>
                    <p class="mb-1"><strong>🏢 Company:</strong> <%= rs.getString("company") %></p>
                    <p class="mb-1"><strong>📍 Location:</strong> <%= rs.getString("location") %></p>
                    <p class="mb-1"><strong>🕒 Experience:</strong> <%= rs.getString("experience") %></p>
                    <p class="mb-1"><strong>📝 Description:</strong> <%= rs.getString("description") %></p>
                </div>
                <div class="text-end" style="min-width: 140px;">
                    <form action="apply_job.jsp" method="post">
                        <input type="hidden" name="jobId" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="btn btn-success px-4 py-2 mt-2">
                            Apply Now
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
            rs.close();
            ps.close();
            conn.close();
        %>
    </div>
</section>

<%@ include file="all_components/Footer.jsp"%>
</body>
</html>
