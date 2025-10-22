<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSS -->
    <link rel="stylesheet" href="CSS/style.css">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>

    <!-- Owl Carousel CSS & JS -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

	<!-- Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <title>SmartHub</title>
    
    <style>
    /* -------------------------------------------------------------------------------- // 🎨 Apple-Inspired Dark Mode UI // -------------------------------------------------------------------------------- */
:root {
	--apple-dark-bg: #141417; /* Very dark background */
	--apple-card-bg: rgba(29, 29, 31, 0.8); /* Dark Frosted Glass */
	--apple-text-primary: #f5f5f7; /* Near-white for primary text */
	--apple-text-secondary: #86868b; /* Subtle grey for secondary text */
	--apple-accent-blue: #007aff; /* Apple Blue */
	--apple-success-green: #34c759; /* Apple Success Green */
	--apple-border-color: rgba(68, 68, 70, 0.4);
}

body {
	background-color: var(--apple-dark-bg) !important;
	color: var(--apple-text-primary); /* Use system font for Apple feel */
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
}

	/* ---------------------------------- // Navbar // ---------------------------------- */
.navbar {
	border-bottom: 1px solid var(--apple-border-color);
	background-color: var(--apple-dark-bg);
	/* Opaque for scrolling clarity */
}

.navbar-brand {
	color: var(--apple-text-primary) !important;
	font-weight: 700;
	letter-spacing: -0.5px;
}
.nav-link.active {
  color: white !important;
}
.nav-link {
	color: var(--apple-text-secondary) !important;
	font-weight: 500;
	padding: 0.5rem 1rem;
	transition: color 0.2s, background-color 0.2s;
}

.nav-link:hover, .nav-link:focus  {
	color: var(--apple-text-primary) !important;
}


.bi {
	font-size: 1.2rem;
}
    </style>
</head>

<body class="">
    <section class="header">
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand text-white fw-bold gradient-heading" href="#">
                    
                        SmartHub
                </a>
                <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                    <ul class="navbar-nav mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">HOME</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="shop.jsp">SHOP</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">BLOG</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">PAGES</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">ABOUT</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./contact.jsp">CONTACT</a>
                        </li>
                    </ul>
                </div>
                <div class="d-flex align-items-center">
                    <ul class="navbar-nav flex-row">
                        <li class="nav-item px-2">
                            <a class="nav-link" href="#"><i class="bi bi-search"></i></a>
                        </li>
                        <!-- 
                        <li class="nav-item px-2">
                            <a class="nav-link" href="logIn.jsp"><i class="bi bi-person"></i></a>
                        </li>
                         -->
                        <li class="nav-item px-2">
                            <a class="nav-link" href="order.jsp"><i class="bi bi-card-checklist"></i></a>
                        </li>
                        <li class="nav-item px-2">
                            <a class="nav-link" href="./cart.jsp"><i class="bi bi-bag"></i></a>
                        </li>
                        <li class="nav-item px-2"><a class="nav-link" href="LogoutServlet" data-bs-toggle="tooltip" data-bs-placement="bottom" 
     						title="<%= session.getAttribute("userName") %>">
    						<i class="bi bi-person"></i>
  							</a>
						</li>
                    </ul>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>
            </div>
        </nav>
    </section>


 <!-- 
 <div class="container mt-5">
        <h2>Welcome, <%= session.getAttribute("userName") %>!</h2>
        <p>You are logged in with email: <%= session.getAttribute("userEmail") %></p>
        <a href="LogoutServlet" class="btn btn-danger">Logout</a>
    </div>
-->

    <!-- Hero Section -->
    <section class="hero container">
        <div class="hero-text col-lg-8 col-md-8" data-aos="fade-right">
            <h1 class="gradient-heading">Discover the Perfect Phone<br>for Your Needs</h1>
            <p>Compare. Analyze. Decide. SmartPhone helps you find the ideal phone through AI suggestions, real reviews,
                and
                expert guidance.</p>

            <div class="hero-buttons">
                <a href="shop.jsp" class="btn btn-explore">Explore Phones</a>
                <a href="#" class="btn btn-smart">Get Smart Suggestions</a>
            </div>

            <div class="search-box">
                <input type="text" placeholder="Search phones by name, brand, or feature...">
            </div>
        </div>

        <div class="hero-img col-lg-5 col-md-5" data-aos="fade-left">
            <img src="Assets/Imges/bg/iphone16pro.png" alt="Phone">
        </div>
    </section>


    <!-- Hero Section -->
    <section class="Carousel Section">

        <div id="mobileCarousel" class="carousel slide carousel-fade mt-4 container" data-bs-ride="carousel">
            <div class="carousel-inner">

                <div class="carousel-item active">
                    <div class="d-flex justify-content-center align-items-center">
                        <div>
                            <section class="banner text-white col-sm-8" data-aos="fade-up">
                                <h2>Your One-Stop Mobile Destination</h2>
                                <p class="mb-4">Latest Smartphones | Best Prices | Fast Delivery</p>
                                <a href="#" class="btn btn-explore btn-explore2">Shop Now</a>
                            </section>
                        </div>
                        <div class="col-sm-4">
                            <img src=".\Assets\Imges\bg\Hero-carousal1.png" class="d-block w-100" alt="Smartphone 2">
                        </div>
                    </div>
                </div>

                <div class="carousel-item ">

                    <div class="d-flex justify-content-center align-items-center">
                        <div>
                            <img src=".\Assets\Imges\bg\Hero-carousal2.png" class="d-block " alt="Smartphone 1">
                        </div>
                        <div>
                            <section class="banner text-white" data-aos="fade-up">
                                <h2>Discover the Future in Your Hands</h2>
                                <p class="mb-4">Experience cutting-edge technology and stunning designs in our latest
                                    smartphones.</p>
                                <a href="#" class="btn btn-explore">Explore Now</a>
                            </section>
                        </div>

                    </div>

                </div>

                <div class="carousel-item">
                    <div class="d-flex justify-content-center align-items-center">
                        <div class="ps-5">
                            <section class="banner text-white ps-5" data-aos="fade-up">
                                <h2>Unbeatable Deals, Unmatched Quality</h2>
                                <p class="mb-4">Grab your dream phone today with exciting offers and fast doorstep
                                    delivery.</p>
                                <a href="#" class="btn btn-explore">Shop Deals</a>
                            </section>
                        </div>
                        <div>
                            <img src=".\Assets\Imges\bg\Hero-carousal3.png" class="d-block" alt="Smartphone 3">
                        </div>
                    </div>
                </div>

            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mobileCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mobileCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
		</div>
    </section>

    <!-- quick-access Section  -->
    <section class="quick-access container ">
        <div class="row text-center g-4">

            <!-- Smartphones -->
            <div class="col-md-3">
                <div class="quick-access-div p-4 h-100">
                    <img src="./Assets/Imges/icons/smartPhone_white.png" alt="Smartphones" class="mb-3" width="60">
                    <h5 class="text-white">Smartphones</h5>
                    <p class="text-white">Latest flagship & budget phones.</p>
                    <a href="shop.jsp?categoryForm=Smartphones" class="btn btn-outline-light btn-sm">Shop Now</a>
                </div>
            </div>

            <!-- Accessories -->
            <div class="col-md-3">
                <div class="quick-access-div p-4 h-100">
                    <img src="./Assets/Imges/icons/charger.png" alt="Accessories" class="mb-3" width="60">
                    <h5 class="text-white">Accessories</h5>
                    <p class="text-white">Cases, chargers & more.</p>
                    <a href="shop.jsp?categoryForm=Accessories" class="btn btn-outline-light btn-sm">Shop Now</a>
                </div>
            </div>

            <!-- Smartwatches -->
            <div class="col-md-3">
                <div class="quick-access-div p-4 h-100">
                    <img src="./Assets/Imges/icons/wrist-watch.png" alt="Smartwatches" class="mb-3" width="60">
                    <h5 class="text-white">Smartwatches</h5>
                    <p class="text-white">Stay connected on the go.</p>
                    <a href="shop.jsp?categoryForm=Smartwatch" class="btn btn-outline-light btn-sm">Shop Now</a>
                </div>
            </div>

            <!-- Audio Devices -->
            <div class="col-md-3">
                <div class="quick-access-div p-4 h-100">
                    <img src="./Assets/Imges/icons/headphones.png" alt="Audio Devices" class="mb-3" width="60">
                    <h5 class="text-white">Audio Devices</h5>
                    <p class="text-white gradient-heading">Headphones & earbuds.</p>
                    <a href="shop.jsp?categoryForm=Audio Device" class="btn btn-outline-light btn-sm">Shop Now</a>
                </div>
            </div>

        </div>
    </section>

    <!-- Best Selling Mobiles Section -->
    <section class="best-selling   text-white">
        <div class="container my-5">
            <h2 class="gradient-heading text-center fw-bold mb-4" data-aos="zoom-in-right">Best Selling Mobiles</h2>
            <div class="owl-carousel owl-theme">

                <!-- Product Card -->
                <div class="card bg-dark text-white border-0 shadow-sm">
                    <img src="./Assets/Imges/mobiles/iphone14.png" class="card-img-top" alt="iPhone 14">
                    <div class="card-body text-center">
                        <h5 class="card-title">iPhone 15 pro</h5>
                        <p class="card-text">₹79,999</p>
                        <div class="d-flex justify-content-center gap-5">
                            <a href="shop.jsp?search=iPhone 15 pro&categoryForm=Smartphones" class="btn btn-light justify-content-end btn-sm w-50">View</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card -->
                <div class="card bg-dark text-white border-0 shadow-sm">
                    <img src="./Assets/Imges/mobiles/Galaxy-S23-No-Background.png" class="card-img-top"
                        alt="Samsung S23">
                    <div class="card-body text-center">
                        <h5 class="card-title">Samsung S23</h5>
                        <p class="card-text">₹69,999</p>
                        <div class="d-flex justify-content-center gap-5">
                            <a href="shop.jsp?search=Samsung S23&categoryForm=Smartphones" class="btn btn-light justify-content-end btn-sm w-50">View</a>
                        </div>
                    </div>
                </div>

                <!-- Product Card -->
                <div class="card bg-dark text-white border-0  shadow-sm">
                    <img src="./Assets/Imges/mobiles/13R-Trail.png" class="card-img-top" alt="OnePlus 11">
                    <div class="card-body text-center">
                        <h5 class="card-title">OnePlus 11</h5>
                        <p class="card-text">₹59,999</p>
                        <div class="d-flex justify-content-center gap-5">
                            <a href="shop.jsp?search=OnePlus 11&categoryForm=Smartphones" class="btn btn-light justify-content-end btn-sm w-50">View</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>


    <!-- Special Offers Section -->
    <section class="special-offers my-5 py-5 bg-dark text-white">
  <div class="container">

    <!-- Gradient Heading -->
    <h2 class="gradient-heading text-center mb-3 fw-bold" data-aos="zoom-in-right">💥 Special Offers </h2>

    <!-- Countdown Timer -->
    <div class="text-center mb-4">
      <h5 class="fw-bold">⏳ Hurry! Offer ends in
        <span id="deal-timer" class="text-warning">00:00:00</span>
      </h5>
    </div>

    <!-- Deals Grid -->
    <div class="row g-4 mb-5">
      <!-- Deal Card 1 -->
      <div class="col-md-4">
        <div class="special-offerscard frosted-card h-100">
          <img src="./Assets/Imges/mobiles/iphone14.png" class="card-img-top" alt="iPhone 14 Pro">
          <div class="card-body text-center">
            <h5 class="card-title">iPhone 14 Pro</h5>
            <p class="card-text"><del class="text-white">₹1,29,999</del>
              <span class="text-success fw-bold">₹1,09,999</span>
            </p>
            <a href="#" class="btn btn-light btn-sm">Grab Deal</a>
          </div>
        </div>
      </div>

      <!-- Deal Card 2 -->
      <div class="col-md-4">
        <div class="special-offerscard frosted-card h-100">
          <img src="./Assets/Imges/mobiles/s25-ultra.png" class="card-img-top" alt="Samsung S23 Ultra">
          <div class="card-body text-center">
            <h5 class="card-title">Samsung S23 Ultra</h5>
            <p class="card-text"><del class="text-white">₹1,19,999</del>
              <span class="text-success fw-bold">₹94,999</span>
            </p>
            <a href="#" class="btn btn-light btn-sm">Grab Deal</a>
          </div>
        </div>
      </div>

      <!-- Deal Card 3 -->
      <div class="col-md-4">
        <div class="special-offerscard frosted-card h-100">
          <img src="./Assets/Imges/mobiles/13R-Trail.png" class="card-img-top" alt="OnePlus 13R">
          <div class="card-body text-center">
            <h5 class="card-title">OnePlus 13R</h5>
            <p class="card-text"><del class="text-white">₹49,999</del>
              <span class="text-success fw-bold">₹39,999</span>
            </p>
            <a href="#" class="btn btn-light btn-sm">Grab Deal</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Highlighted Special Offer Features -->
    
    <p class="text-center fw-bold my-5" >Checkout our latest deals and discounts on top <br> mobile phones and accessories</p>
    <div class="row d-flex justify-content-around  g-4">
      <div class="special-card col-md-5">
        <div class="d-flex p-3 border rounded h-100 bg-transparent">
        	<div class="col-md-3 text-center d-flex justify-content-center ">
        		<i class="bi bi-truck fs-1 text-warning mt-2"></i>
        	</div>
         <div class="col-md-9">
         	<h4 class="mt-3">Free Delivery</h4>
          <p class="small">Enjoy free shipping on all orders with no minimum purchase required.</p>
         </div>
          
        </div>
      </div>
      
      <div class="special-card col-md-5">
        <div class="d-flex p-3 border rounded h-100 bg-transparent">
        	<div class="col-md-3 text-center d-flex justify-content-center ">
        		<i class="bi bi-arrow-repeat fs-1 text-warning mt-2"></i>
        	</div>
         <div class="col-md-9">
         	<h4 class="mt-3">30-Day Returns</h4>
          <p class="small">Return or exchange your purchase within 30 days for a full refund.</p>
         </div>
        </div>
      </div>

	  <div class="special-card col-md-5">
        <div class="d-flex p-3 border rounded h-100 bg-transparent">
        	<div class="col-md-3 text-center d-flex justify-content-center ">
        		<i class="bi bi-headset fs-1 text-warning mt-2"></i>
        	</div>
         <div class="col-md-9">
         	<h4 class="mt-3">24/7 Support</h4>
          <p class="small">Our customer support team is available 24/7 to assist you anytime.</p>
         </div>
        </div>
      </div>
      
      <div class="special-card col-md-5">
        <div class="d-flex p-3 border rounded h-100 bg-transparent">
        	<div class="col-md-3 text-center d-flex justify-content-center ">
        		<i class="bi bi-shield-lock fs-1 text-warning mt-2"></i>
        	</div>
         <div class="col-md-9">
         	<h4 class="mt-3">Secure Payment</h4>
          <p class="small">Our customer support team .</p>
         </div>
        </div>
      </div>
      
    </div>

  </div>
</section>
    
    <!-- 4.  New Arrivals Section -->
    <section class="New-Arrivals container ">
        <!-- Gradient Heading -->
        <h2 class="gradient-heading fw-bold mb-2" data-aos="zoom-in-right"> New Arrivals</h2> <br>
        <p class=" text-white gradient-subheading-1 mb-5">Check out the latest launched smartphones</p>

        <div class="row g-4">
            <!-- Product 1 -->
            <div class="col-md-4 col-sm-6 ">
                <div class="card shadow-sm h-100  bg-dark text-center border-0 rounded-4">
                    <div class="position-relative">
                        <span class="badge bg-danger position-absolute top-0 start-0 m-2 rounded-pill px-3 py-2">Just
                            Launched!</span>
                        <img src="./Assets/Imges/mobiles/Apple-Iphone-17-Pro-Max-b-original-removebg-preview.png" class="card-img-top p-3" alt="New Mobile">
                    </div>
                    <div class="card-body text-white">
                        <h5 class="card-title gradient-subheading-1">iPhone 17 Pro</h5>
                        <p class="card-text">From ₹1,38,900</p>
                        <button class="btn btn-dark rounded-pill px-4">Buy Now</button>
                    </div>
                </div>
            </div>

            <!-- Product 2 -->
            <div class="col-md-4 col-sm-6">
                <div class="card shadow-sm h-100 bg-dark  text-center border-0 rounded-4">
                    <div class="position-relative">
                        <span class="badge bg-danger position-absolute top-0 start-0 m-2 rounded-pill px-3 py-2">Just
                            Launched!</span>
                        <img src="./Assets/Imges/mobiles/Samsung_Galaxy_Z_Fold7.png" class="card-img-top p-3"
                            alt="New Mobile">
                    </div>
                    <div class="card-body text-white">
                        <h5 class="card-title gradient-subheading-1">Samsung Galaxy Z Fold7</h5>
                        <p class="card-text">From ₹1,49,999</p>
                        <button class="btn btn-dark rounded-pill px-4">Buy Now</button>
                    </div>
                </div>
            </div>

            <!-- Product 3 -->
            <div class="col-md-4 col-sm-6">
                <div class="card shadow-sm h-100 bg-dark text-center border-0 rounded-4">
                    <div class="position-relative">
                        <span class="badge bg-danger position-absolute top-0 start-0 m-2 rounded-pill px-3 py-2">Just
                            Launched!</span>
                        <img src="./Assets/Imges/mobiles/pixel-10.png" class="card-img-top p-3" alt="New Mobile">
                    </div>
                    <div class="card-body text-white">
                        <h5 class="card-title gradient-subheading-1">Google Pixel 10</h5>
                        <p class="card-text">From ₹69,999</p>
                        <button class="btn btn-dark rounded-pill px-4">Buy Now</button>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- Reviews Section -->
    <section class="Reviews container">
        <h2 class="gradient-heading text-center mb-4" data-aos="zoom-in-right">📝 Customer Reviews</h2>

        <div class="row g-4">
            <!-- Review 1 -->
            <div class="col-md-4">
                <div class="testimonial-card">
                    <p data-aos="zoom-in-down">"Amazing shopping experience! Got my iPhone delivered in 2 days 😍"</p>
                    <div class="stars">⭐⭐⭐⭐⭐</div>
                    <h6>- Rahul Sharma</h6>
                </div>
            </div>

            <!-- Review 2 -->
            <div class="col-md-4">
                <div class="testimonial-card">
                    <p data-aos="zoom-in-down">"Great offers and genuine products. My Galaxy S24 deal was a steal! 🔥"
                    </p>
                    <div class="stars">⭐⭐⭐⭐⭐</div>
                    <h6>- Sneha Verma</h6>
                </div>
            </div>

            <!-- Review 3 -->
            <div class="col-md-4">
                <div class="testimonial-card">
                    <p data-aos="zoom-in-down">"Customer support is really helpful and responsive. Recommended! 👍"</p>
                    <div class="stars">⭐⭐⭐⭐⭐</div>
                    <h6>- Aman Gupta</h6>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter container ">
        <h2>Get exclusive deals in your inbox!</h2>
        <p>Subscribe to our newsletter & never miss an offer.</p>

        <form class="row justify-content-center align-items-center mt-4">
            <div class="col-md-6 col-10">
                <input type="email" class="form-control" placeholder="Enter your email" required>
            </div>
            <div class="col-auto mt-2 mt-md-0">
                <button type="submit" class="btn">Subscribe</button>
            </div>
        </form>
    </section>


    <!-- footer -->
    <footer class="footer mt-5">
        <div class="container">
            <!-- Links -->
            <div class="mb-3">
                <a href="#">About Us</a> |
                <a href="#">Contact</a> |
                <a href="#">FAQs</a> |
                <a href="#">Policies</a>
            </div>

            <!-- Social Icons -->
            <div class="social-icons mb-3">
                <a href="#"><i class="bi bi-facebook"></i></a>
                <a href="#"><i class="bi bi-twitter-x"></i></a>
                <a href="#"><i class="bi bi-instagram"></i></a>
                <a href="#"><i class="bi bi-youtube"></i></a>
            </div>

            <!-- Copy -->
            <p class="mb-0">&copy; 2025 MobileShop. All Rights Reserved.</p>
        </div>
    </footer>

    

    <!-- Countdown Timer Script -->
    <script>
        let countdownDate = new Date().getTime() + (3 * 60 * 60 * 1000);
        let x = setInterval(function () {
            let now = new Date().getTime();
            let distance = countdownDate - now;

            let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            let seconds = Math.floor((distance % (1000 * 60)) / 1000);

            document.getElementById("deal-timer").innerHTML =
                (hours < 10 ? "0" : "") + hours + ":" +
                (minutes < 10 ? "0" : "") + minutes + ":" +
                (seconds < 10 ? "0" : "") + seconds;

            if (distance < 0) {
                clearInterval(x);
                document.getElementById("deal-timer").innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>

    <!-- Owl Carousel Initialization -->
    <script>
        $(document).ready(function () {
            $(".owl-carousel").owlCarousel({
                loop: true,
                margin: 15,
                nav: true,
                dots: false,
                autoplay: true,
                autoplayTimeout: 3000,
                responsive: {
                    0: { items: 1 },
                    576: { items: 2 },
                    992: { items: 3 },
                    1200: { items: 4 }
                }
            });
        });
    </script>

    <!-- Bootstrap + AOS Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({
            duration: 1800,
            once: true,
        });
    </script>
    
    <!-- Initialize tooltip person icon login -->
<script>
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
</script>
</body>

</html>
