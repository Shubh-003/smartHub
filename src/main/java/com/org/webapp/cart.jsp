<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("logIn.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    double total = 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Cart - Smartph</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
  <link rel="stylesheet" href="./CSS/style.css" />
  <style>
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
  .quantity-group {
  width: 120px;
}
.quantity-btn {
  width: 30px;
  height: 30px;
  line-height: 15px;
  font-size:20px ;
  color: white;
  background-color: transparent;
  border: none;
  transition: 0.2s;
}
.quantity-btn:hover {
  background-color: gray;
  border-radius: 40%;
  color: #fff;
}
.quantity-input {
  border: none;
  background-color: transparent !important ;
  font-weight: 500;
}

small{
font-size:12px;
}
  
  </style>
</head>

<body class="bg-dark">
  <!-- Navbar -->
        <section class="header">
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand text-white fw-bold gradient-heading" href="#">
                    
                        SmartHub
                </a>
                <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                    <ul class="navbar-nav mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link " href="index.jsp">HOME</a>
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
                            <a class="nav-link active" href="./cart.jsp"><i class="bi bi-bag"></i></a>
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

  <section class="container my-5">
    <div class="text-white justify-content-center text-center mb-5">
      <%
        try {
            con = DBConnection.getConnection();
            String query = "SELECT c.cart_id, c.quantity, c.discount_price, p.prod_name, p.prod_desc, p.prod_img, p.prod_mrp " +
                    "FROM cart c JOIN products p ON c.product_id = p.prodId WHERE c.user_id=?";

            ps = con.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

            ps.setInt(1, userId);
            rs = ps.executeQuery();

            // Calculate total
            while (rs.next()) {
                total += rs.getDouble("discount_price") * rs.getInt("quantity");
            }
            rs.beforeFirst(); // reset cursor
      %>
      <h2>Your bag total is ₹<%= String.format("%.2f", total) %> or ₹<%= String.format("%.2f", total/12) %>/mo. with EMI</h2>
      <a class="CheckOut btn btn-primary my-4" href="./checkOut.jsp">Check Out</a>
      <hr>
    </div>

    <!-- Cart Items Loop -->
    <%
        while (rs.next()) {
            String name = rs.getString("prod_name");
            String desc = rs.getString("prod_desc");
            String img = rs.getString("prod_img");
            double price = rs.getDouble("discount_price");
            double mrp = rs.getDouble("prod_mrp");
            int qty = rs.getInt("quantity");
            double subTotal = price * qty;
            double savings = (mrp - price) * qty;

    %>

    <div class="frosted-card p-4 mb-4">
      <div class="row align-items-center">
        <div class="col-md-2">
          <img src="<%= img %>" class="img-fluid rounded col-lg-8" alt="Product Image">
        </div>
        
        <div class="col-md-4">
          <h5 class="text-white"><%= name %></h5>
          <small class="text-secondary d-block"><%= desc %></small>
          <small class="text-secondary d-block">Deliver to Pin Code 422402 — Free by two day's</small>
          <small class="text-secondary d-block">Pick up in-store: 20 oct at pune</small>
        </div>
        
        <div class="col-md-2 text-center">
 	<form action="<%= request.getContextPath() %>/UpdateCartServlet" method="post" class="update-form d-inline"> 
 	<input type="hidden" name="action" value="update">
    <input type="hidden" name="cart_id" value="<%= rs.getInt("cart_id") %>">

    <div class="input-group quantity-group justify-content-center">
      <button type="button" class="btn btn-outline-light btn-sm quantity-btn minus-btn">−</button>
      <input type="text" name="quantity" class="form-control text-center bg-dark text-white quantity-input"
             value="<%= qty %>" readonly style="max-width: 60px;">
      <button type="button" class="btn btn-outline-light btn-sm quantity-btn plus-btn">+</button>
    </div>
  </form>
</div>
        
        <div class="col-md-2 text-center text-white">
          ₹<%= String.format("%.2f", subTotal) %><br>
          <small class="text-secondary">₹<%= String.format("%.2f", price) %>/unit</small>
          <small class="d-block text-success">Get up to ₹<%= String.format("%.2f", (rs.getDouble("prod_mrp") - price) * rs.getInt("quantity")) %> savings with eligible offer(s)*</small>
        </div>
        <div class="col-md-2 text-center">
          <form action="<%= request.getContextPath() %>/UpdateCartServlet" method="post" class="remove-form d-inline">
  				<input type="hidden" name="action" value="remove">
  				<input type="hidden" name="cart_id" value="<%= rs.getInt("cart_id") %>">
  				<button type="submit" class="btn btn-link text-decoration-none text-danger remove-btn">Remove</button>
		 </form>
        </div>
      </div>
    </div>

    <% } %>

    <!-- Cart Summary -->
    <div class="frosted-card col-lg-6 justify-content-center p-4 text-white">
      <h4 class="mb-4">Order Summary</h4>
      <div class="d-flex justify-content-between mb-2">
        <span>Bag Subtotal</span>
        <span>₹<%= String.format("%.2f", total) %></span>
      </div>
      <div class="d-flex justify-content-between mb-2">
        <span>Shipping</span>
        <span>₹0.00</span>
      </div>
      <hr class="bg-secondary">
      <div class="d-flex justify-content-between mb-2">
        <strong>Total</strong>
        <strong>₹<%= String.format("%.2f", total) %></strong>
      </div>
      <small class="d-block text-secondary mb-2">Monthly payment ₹<%= String.format("%.2f", total/12) %>/mo. with EMI</small>
      <%
    // Calculate total savings for all items
    double totalSavings = 0;
    rs.beforeFirst();
    while (rs.next()) {
        totalSavings += (rs.getDouble("prod_mrp") - rs.getDouble("discount_price")) * rs.getInt("quantity");
    }
%>
<small class="d-block text-success">Total savings of ₹<%= String.format("%.2f", totalSavings) %></small>

      <a class="btn btn-explore w-100 mt-3" href="./checkOut.jsp">Check Out</a>
    </div>

    <%
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>
  </section>

  <!-- footer -->
  <footer class="footer mt-5">
    <div class="container">
      <div class="mb-3">
        <a href="#">About Us</a> |
        <a href="#">Contact</a> |
        <a href="#">FAQs</a> |
        <a href="#">Policies</a>
      </div>
      <div class="social-icons mb-3">
        <a href="#"><i class="bi bi-facebook"></i></a>
        <a href="#"><i class="bi bi-twitter-x"></i></a>
        <a href="#"><i class="bi bi-instagram"></i></a>
        <a href="#"><i class="bi bi-youtube"></i></a>
      </div>
      <p class="mb-0">&copy; 2025 MobileShop. All Rights Reserved.</p>
    </div>
  </footer>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
  <script>
document.addEventListener("DOMContentLoaded", function() {
  const forms = document.querySelectorAll(".update-form");

  forms.forEach(form => {
    const minusBtn = form.querySelector(".minus-btn");
    const plusBtn = form.querySelector(".plus-btn");
    const quantityInput = form.querySelector(".quantity-input");
    const priceText = form.closest(".row").querySelector(".text-white").nextElementSibling;
    const subtotalElement = form.closest(".row").querySelector(".col-md-2.text-center.text-white");
    
    const price = parseFloat(subtotalElement.querySelector("small").innerText.replace("₹", "").replace("/unit", "").trim());
    const orderSummaryTotal = document.querySelectorAll(".frosted-card span:last-child strong, .frosted-card div strong:last-child");
    
    const updateTotals = () => {
      // Update subtotal
      const newSubtotal = (price * parseInt(quantityInput.value)).toFixed(2);
      subtotalElement.innerHTML = `₹${newSubtotal}<br><small class="text-secondary">₹${price.toFixed(2)}/unit</small>`;

      // Update total
      let total = 0;
      document.querySelectorAll(".col-md-2.text-center.text-white").forEach(st => {
        total += parseFloat(st.innerText.replace("₹", ""));
      });
      document.querySelectorAll(".frosted-card strong:last-child").forEach(str => str.innerText = `₹${total.toFixed(2)}`);
      document.querySelector(".text-center h2").innerText = `Your bag total is ₹${total.toFixed(2)}`;
    };

    minusBtn.addEventListener("click", () => {
      let value = parseInt(quantityInput.value);
      if (value > 1) {
        quantityInput.value = value - 1;
        form.submit();
        updateTotals();
      }
    });

    plusBtn.addEventListener("click", () => {
      let value = parseInt(quantityInput.value);
      if (value < 10) {
        quantityInput.value = value + 1;
        form.submit();
        updateTotals();
      }
    });
  });
});
</script>
  
  
  
</body>
</html>
