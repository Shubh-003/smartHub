<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact & Help - Mobile Shop</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="CSS/style.css">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: rgb(247, 247, 247) !important;
            color: black;
            font-family: 'Poppins', sans-serif;
        }
        
        .nav-link.active {
  color: white !important;
}

        .frosted-card {
            background: rgba(255, 255, 255, 0.416);
            border-radius: 16px;
            padding: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(0,0,0,0.4);
            max-width: 700px;
            margin: 50px auto;
        }

        .form-control, .form-select {
           background: rgba(213, 212, 212, 0.853);
           color: rgba(0, 0, 0, 0.74);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
		/* Placeholder color */
		::placeholder {
  			  color: #3938386c !important;  /* light white */
  			  opacity: 1; /* ensures consistent color in all browsers */
		}
		
        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.641);
            border-color: #0d6efd;
            box-shadow: none;
            color: black;
        }

        label {
            font-weight: 500;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

    <section class="header">
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand text-white fw-bold gradient-heading" href="#">
                    
                        SmartHub
                </a>
                <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                    <ul class="navbar-nav mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">HOME</a>
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
                            <a class="nav-link active" href="./contact.jsp">CONTACT</a>
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


    
<section>
    <div class="container">
        <div class="frosted-card">
            <h2 class="text-center mb-4">Support</h2>
            <p class="text-center text-secondary mb-4">Have questions, issues, or feedback? Fill out the form below.</p>

            <form action="ContactServlet" method="post">
                
                <!-- Full Name -->
                <div class="mb-3">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="John Doe" required>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="john@example.com" required>
                </div>

                <!-- Phone -->
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone" placeholder="+91 9876543210" required>
                </div>

                <!-- Query Type -->
                <div class="mb-3">
                    <label for="queryType" class="form-label">Query Type</label>
                    <select class="form-select " id="queryType" name="queryType" required>
                        <option value="" class="text-dark">-- Select --</option>
                        <option value="General" class="text-dark">General Inquiry</option>
                        <option value="Order" class="text-dark">Order Issue</option>
                        <option value="Technical" class="text-dark">Technical Support</option>
                        <option value="Feedback" class="text-dark">Feedback</option>
                    </select>
                </div>

                <!-- Order ID (Optional) -->
                <div class="mb-3">
                    <label for="orderId" class="form-label">Order ID (if applicable)</label>
                    <input type="text" class="form-control" id="orderId" name="orderId" placeholder="e.g. ORD12345">
                </div>

                <!-- Message -->
                <div class="mb-3">
                    <label for="message" class="form-label">Your Message</label>
                    <textarea class="form-control" id="message" name="message" rows="4" placeholder="Write your query here..." required></textarea>
                </div>

                <!-- Submit -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg">Submit Request</button>
                </div>
            </form>
        </div>
    </div>
</section>


    <!-- footer -->
    <footer class="footer mt-5 bg-dark">
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
    
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
