<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("logIn.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - SmartHub</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body { background-color: #0d0d0d; color: #fff; font-family: 'Poppins', sans-serif; }
        .checkout-container { background: #1a1a1a; border-radius: 10px; padding: 30px; max-width: 900px; margin: 30px auto; }
        .payment-methods { display:flex; gap:12px; margin-top:20px; }
        .payment-card { border:1px solid #333; padding:18px; border-radius:10px; background:#0f0f0f; cursor:pointer; transition: border-color 0.3s ease, box-shadow 0.3s ease; }
        .payment-card.active { border-color:#0d6efd; box-shadow:0 4px 16px rgba(13,110,253,0.12);}
        .small-muted { color:#adb5bd; font-size:0.9rem; }

        /* --- ✨ Updated UI & Transition Styles Start ✨ --- */

        /* Base container for forms that will transition */
        .transition-form {
            overflow: hidden;
            max-height: 0;
            opacity: 0;
            margin-top: 0;
            padding: 0 20px;
            background-color: #252525;
            border-radius: 10px;
            transition: max-height 0.5s ease-in-out, opacity 0.4s ease-in-out, margin-top 0.5s ease-in-out, padding 0.5s ease-in-out;
        }

        /* 'show' class to trigger the transition */
        .transition-form.show {
            max-height: 500px; /* Large enough to fit content */
            opacity: 1;
            margin-top: 20px;
            padding: 24px 20px;
        }

        /* Apple-like styling for form inputs */
        #cardForm .form-control {
            background-color: #333;
            border: 1px solid #444;
            color: #fff;
            border-radius: 8px;
            padding: 12px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        #cardForm .form-control::placeholder {
            color: #888;
        }

        #cardForm .form-control:focus {
            background-color: #333;
            color: #fff;
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.25);
            outline: none; /* Remove default browser outline */
        }

        /* Styling for form labels */
        #cardForm .form-label {
            margin-bottom: 8px;
            font-weight: 500;
        }

        /* --- Updated UI & Transition Styles End --- */
    </style>
</head>
<body>
    <section class="header">
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand text-white fw-bold gradient-heading" href="#">SmartHub</a>
                <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                    <ul class="navbar-nav mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="index.jsp">HOME</a></li>
                        <li class="nav-item"><a class="nav-link" href="shop.jsp">SHOP</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">BLOG</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">PAGES</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">ABOUT</a></li>
                        <li class="nav-item"><a class="nav-link" href="./contact.jsp">CONTACT</a></li>
                    </ul>
                </div>
                <div class="d-flex align-items-center">
                    <ul class="navbar-nav flex-row">
                        <li class="nav-item px-2"><a class="nav-link" href="#"><i class="bi bi-search"></i></a></li>
                        <li class="nav-item px-2"><a class="nav-link" href="#"><i class="bi bi-heart"></i></a></li>
                        <li class="nav-item px-2"><a class="nav-link" href="./cart.jsp"><i class="bi bi-bag"></i></a></li>
                        <li class="nav-item px-2">
                            <a class="nav-link" href="LogoutServlet"
                                data-bs-toggle="tooltip"
                                data-bs-placement="bottom"
                                title="<%= session.getAttribute("userName") %>">
                                <i class="bi bi-person"></i>
                            </a>
                        </li>
                    </ul>
                    <button class="navbar-toggler" type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent"
                        aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>
            </div>
        </nav>
    </section>

    <div class="checkout-container">
        <h2>Checkout</h2>
        <hr>
        <h3 class="mt-4" >How would you like to get your order?</h3>
        <div class="payment-methods">
            <div id="cardOption" class="payment-card active" data-method="card">
                <strong>Credit / Debit Card</strong>
            </div>
            <div id="codOption" class="payment-card" data-method="cod">
                <strong>Cash On Delivery</strong>
            </div>
        </div>

        <form id="paymentForm" action="<%= request.getContextPath() %>/ProcessPaymentServlet" method="post" class="mt-4">
            <input type="hidden" name="payment_method" id="payment_method" value="card">

            <div id="cardForm" class="transition-form show">
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label small-muted">Card Number</label>
                        <input type="text" name="card_number" class="form-control" placeholder="1234 5678 9012 3456" maxlength="19" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small-muted">Name on Card</label>
                        <input type="text" name="card_name" class="form-control" placeholder="Full name as on card" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small-muted">Expiry (MM/YY)</label>
                        <input type="text" name="card_exp" class="form-control" placeholder="MM/YY" maxlength="5" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small-muted">CVV</label>
                        <input type="password" name="card_cvv" class="form-control" placeholder="•••" maxlength="4" />
                    </div>
                </div>
                <div class="mt-3 small-muted">Note: Card fields are for UI/demo only — we do NOT store card data.</div>
            </div>

            <div id="codNote" class="transition-form">
                <p class="small-muted">You selected Cash On Delivery. Payment will be collected by the delivery partner.</p>
            </div>

            <div class="mt-4 col-lg-6 d-flex gap-3">
                <button type="submit" class="btn btn-primary w-100">Place Order</button>
                <a href="confirmAddress.jsp" class="btn btn-outline-light">Back</a>
            </div>
        </form>
    </div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const cardOpt = document.getElementById('cardOption');
    const codOpt = document.getElementById('codOption');
    const cardForm = document.getElementById('cardForm');
    const codNote = document.getElementById('codNote');
    const paymentMethodInput = document.getElementById('payment_method');

    function setActive(option) {
        if (option === 'card') {
            // Show Card Form
            cardOpt.classList.add('active');
            codOpt.classList.remove('active');
            codNote.classList.remove('show');
            cardForm.classList.add('show');
            paymentMethodInput.value = 'Credit Card';
        } else {
            // Show COD Note
            cardOpt.classList.remove('active');
            codOpt.classList.add('active');
            cardForm.classList.remove('show');
            codNote.classList.add('show');
            paymentMethodInput.value = 'Cash On Delivery';
        }
    }

    cardOpt.addEventListener('click', () => setActive('card'));
    codOpt.addEventListener('click', () => setActive('cod'));
});
</script>
</body>
</html>