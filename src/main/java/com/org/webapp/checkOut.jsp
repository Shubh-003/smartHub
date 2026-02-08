<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout</title>
   
	<!-- CSS -->
    <link rel="stylesheet" href="CSS/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #0d0d0d;
            color: #fff;
            padding: 0px;
        }

        .frosted-card {
            background: rgba(255, 255, 255, 0.034);
            border-radius: 16px;
            padding: 30px;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: auto;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.08);
            color: #fff;
            border-color: #007bff;
            box-shadow: none;
        }

        .btn-primary:hover {
            transform: scale(1.05);
        }

        .order-summary {
            background: rgba(255, 255, 255, 0.08);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
        }

        .order-summary span {
            font-weight: bold;
            color: #fff;
        }

        .form-floating > .form-control,
        .form-floating > .form-select {
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.2);
            height: 60px;
        }

        .form-floating > label {
            color: rgba(255, 255, 255, 0.7);
            background-color: transparent !important;
        }

        .form-floating > .form-control:focus ~ label {
            color: #000000;
            background-color: transparent !important;
        }

        .form-floating {
            margin-bottom: 1rem;
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
                            <a class="nav-link" href="#">SHOP</a>
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
                        <li class="nav-item px-2">
                            <a class="nav-link" href="logIn.jsp"><i class="bi bi-person"></i></a>
                        </li>
                        <li class="nav-item px-2">
                            <a class="nav-link" href="#"><i class="bi bi-heart"></i></a>
                        </li>
                        <li class="nav-item px-2">
                            <a class="nav-link" href="./cart.jsp"><i class="bi bi-bag"></i></a>
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
    
  <section class="mt-5">
    <div class="frosted-card">
        <div class="Checkout-header d-flex flex-wrap align-items-center justify-content-between mb-1">
            <h2>Checkout</h2>
        </div>
        <hr />

        <form method="post" action="SaveAddressServlet">

            <div>
                <h2 class="fw-bold mb-4">Where should we send your order?</h2>
                <h4 class="mb-3">Enter your name and address:</h4>
            </div>

            <div class="form-floating">
                <input type="text" name="firstName" class="form-control" id="firstName" placeholder="First Name" required />
                <label for="firstName">First Name</label>
            </div>

            <div class="form-floating">
                <input type="text" name="address1" class="form-control" id="address1" placeholder="123 Main Street" required />
                <label for="address1">Address Line 1</label>
            </div>

            <div class="form-floating">
                <input type="text" name="address2" class="form-control" id="address2" placeholder="Apartment, suite, etc." />
                <label for="address2">Address Line 2 (Optional)</label>
            </div>

            <div class="form-floating">
                <input type="text" name="landmark" class="form-control" id="landmark" placeholder="Near Park, Opposite Mall" />
                <label for="landmark">Landmark (Optional)</label>
            </div>

		<div class="col col-lg-12 d-flex justify-content-between">
            <div class="form-floating col col-lg-3">
                <input type="text" name="pinCode" class="form-control" id="pinCode" placeholder="411006" required />
                <label for="pinCode">PIN Code</label>
            </div>
            <div class="form-floating col col-lg-4">
                <input type="text" name="city" class="form-control" id="city" placeholder="" required />
                <label for="city">City</label>
            </div>
            <div class="form-floating col col-lg-4">
                <input type="text" name="state" class="form-control" id="state" placeholder="" required />
                <label for="pinCode">State</label>
            </div>
		</div>
            <div class="form-floating">
                <textarea name="instructions" class="form-control" placeholder="Leave at front door..." id="instructions" style="height: 100px;"></textarea>
                <label for="instructions">Delivery Instructions (Optional)</label>
            </div>

            <div class="mt-5 mb-5">
                <h3>What’s your contact information?</h3>

                <div class="form-floating">
                    <input type="text" name="lastName" class="form-control" id="lastName" placeholder="Doe" required />
                    <label for="lastName">Last Name</label>
                </div>

                <div class="form-floating">
                    <input type="email" name="email" class="form-control" id="email" placeholder="john.doe@example.com" required />
                    <label for="email">Email Address</label>
                </div>

                <div class="form-floating">
                    <input type="tel" name="phone" class="form-control" id="phone" placeholder="+91 98765 43210" required />
                    <label for="phone">Phone Number</label>
                </div>
            </div>
            <hr>
            <button type="submit" class="btn btn-primary mt-3">Proceed to Payment</button>
        </form>
    </div>
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
    
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
