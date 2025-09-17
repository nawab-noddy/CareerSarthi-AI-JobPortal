<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="custom-footer mt-auto bg-dark text-light py-4">
    <div class="container text-center">
        <div class="row">
            <!-- Contact Us -->
            <div class="col-md-4 mb-3">
                <h6 class="footer-title">Contact Us</h6>
                <p class="mb-1">Email: <a href="mailto:support@mycompany.com" class="footer-link">support@mycompany.com</a></p>
                <p> Phone: <a href="tel:+919876543210" class="footer-link">+91 9876543210</a></p>
            </div>

            <!-- About -->
            <div class="col-md-4 mb-3">
                <h6 class="footer-title"> About</h6>
                <p class="mb-0">We provide quality services with dedication and integrity.</p>
            </div>

            <!-- Social Icons -->
            <div class="col-md-4 mb-3">
                <h6 class="footer-title">Follow Us</h6>
                <div class="social-icons">
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
    </div>
</footer>

<style>
/* Footer Title Animation */
.footer-title {
    font-weight: bold;
    font-size: 1.2rem;
    position: relative;
    display: inline-block;
}

.footer-title::after {
    content: "";
    display: block;
    width: 0;
    height: 2px;
    background: #f8c146;
    transition: width 0.3s;
    margin: auto;
}

.footer-title:hover::after {
    width: 100%;
}

/* Footer Links */
.footer-link {
    color: #f1f1f1;
    text-decoration: none;
    transition: color 0.3s;
}

.footer-link:hover {
    color: #f8c146;
}

/* Social Icons Styling */
.social-icons {
    display: flex;
    justify-content: center;
    gap: 15px;
}

.social-link {
    font-size: 1.3rem;
    color: #f1f1f1;
    transition: transform 0.3s, color 0.3s;
}

.social-link:hover {
    color: #f8c146;
    transform: scale(1.2) rotate(5deg);
}

/* Smooth Fade-In Animation */
.custom-footer {
    animation: fadeInUp 0.8s ease-in-out;
}

@keyframes fadeInUp {
    from {
        transform: translateY(30px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}
</style>