<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index Page</title>
<%@ include file="all_components/ALL_CDN.jsp"%>

<style>
/* ---------------- Hero Section ---------------- */
.hero-section {
    background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
    text-align: center;
    padding: 80px 20px;
    color: white;
    animation: fadeIn 1s ease-in-out;
}

.hero-section h1 {
    font-weight: bold;
    font-size: 2.8rem;
    animation: slideDown 0.8s ease-in-out;
}

.hero-section p {
    font-size: 1.2rem;
    opacity: 0.9;
    animation: fadeIn 1.5s ease-in-out;
}

/* ---------------- Search Bar ---------------- */
.search-bar {
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50px;
    box-shadow: 0px 4px 15px rgba(0,0,0,0.15);
    padding: 10px;
    margin-top: 30px;
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
}

.search-bar input, .search-bar select {
    border: none;
    outline: none;
    padding: 10px 15px;
    flex: 1;
    font-size: 14px;
    color: #555;
}

.search-bar input::placeholder {
    color: #999;
}

.search-bar button {
    background: linear-gradient(135deg, #ff512f, #dd2476);
    color: white;
    border: none;
    padding: 10px 25px;
    border-radius: 50px;
    font-weight: bold;
    transition: transform 0.2s ease, background 0.3s ease;
}

.search-bar button:hover {
    transform: scale(1.05);
    background: linear-gradient(135deg, #dd2476, #ff512f);
}

/* ---------------- Company Cards ---------------- */
.company-card {
    padding: 15px;
    background: white;
    border-radius: 12px;
    box-shadow: 0px 2px 12px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    animation: fadeUp 0.6s ease forwards;
    opacity: 0;
}

.company-card img {
    max-width: 80px;
    max-height: 80px;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.company-card p {
    margin-top: 8px;
    font-weight: 500;
    color: #333;
    transition: color 0.3s ease;
}

.company-card:hover {
    transform: translateY(-8px) scale(1.05);
    box-shadow: 0px 6px 20px rgba(0,0,0,0.15);
}

.company-card:hover img {
    transform: scale(1.1);
}

.company-card:hover p {
    color: #2575fc;
}

/* ---------------- Animations ---------------- */
@keyframes fadeIn {
    from {opacity: 0;}
    to {opacity: 1;}
}

@keyframes slideDown {
    from {transform: translateY(-20px); opacity: 0;}
    to {transform: translateY(0); opacity: 1;}
}

@keyframes fadeUp {
    from {transform: translateY(20px); opacity: 0;}
    to {transform: translateY(0); opacity: 1;}
}
.company-card {
    padding: 15px;
    background: white;
    border-radius: 12px;
    box-shadow: 0px 2px 12px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    /* NEW: fix height for equal cards */
    height: 150px; 
    min-height: 150px;
}

.company-card img {
    max-width: 80px;
    max-height: 80px;
    object-fit: contain;
    transition: transform 0.3s ease;
    flex-shrink: 0;
}

</style>
</head>
<body>
<%@ include file="all_components/Navbar.jsp"%>

<!-- Hero Section -->
<section class="hero-section">
    <h1>Find Your Dream Job Now</h1>
    <p>Over 500,000+ jobs waiting for you</p>

    <!-- Search bar -->
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

<!-- Top Companies Section -->
<section style="padding: 50px 20px; background: #f8f9fa;">
    <div class="container">
        <h3 class="text-center mb-4" style="font-weight: bold; color: #333;">Top Companies Hiring</h3>
        <div class="row text-center">

            <div class="col-md-2 col-6 mb-3">
                <div class="company-card">
                    <img src="images/google.png" alt="Google">
                    <p>Google</p>
                </div>
            </div>

            <div class="col-md-2 col-6 mb-3">
                <div class="company-card">
                    <img src="images/microsoft.png" alt="Microsoft">
                    <p>Microsoft</p>
                </div>
            </div>

            <div class="col-md-2 col-6 mb-3">
                <div class="company-card">
                    <img src="images/amazon.png" alt="Amazon">
                    <p>Amazon</p>
                </div>
            </div>

            <div class="col-md-2 col-6 mb-3">
                <div class="company-card">
                    <img src="images/infosys.png" alt="Infosys">
                    <p>Infosys</p>
                </div>
            </div>

            <div class="col-md-2 col-6 mb-3">
                <div class="company-card">
                    <img src="images/tcs.jpg" alt="TCS">
                    <p>TCS</p>
                </div>
            </div>

            <div class="col-md-2 col-6 mb-3">
                <div class="company-card">
                    <img src="images/wipro.png" alt="Wipro">
                    <p>Wipro</p>
                </div>
            </div>

        </div>
    </div>
</section>

<%@ include file="all_components/Footer.jsp"%>
</body>
</html>
