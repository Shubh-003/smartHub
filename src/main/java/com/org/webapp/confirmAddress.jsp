<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("logIn.jsp");
        return;
    }

    double totalPrice = 0.0;
    String userName = "", userEmail = "", userPhone = "", userAddress = "", userCity = "", userState = "", userPincode = "";

    try (Connection con = DBConnection.getConnection()) {
        // Fetch user details
        PreparedStatement psUser = con.prepareStatement("SELECT * FROM registration WHERE userId=?");
        psUser.setInt(1, userId);
        ResultSet rsUser = psUser.executeQuery();
        if (rsUser.next()) {
            userName = rsUser.getString("userName");
            userEmail = rsUser.getString("userEmail");
            userPhone = rsUser.getString("userPhone");
            userAddress = rsUser.getString("userAddress");
            userCity = rsUser.getString("userCity");
            userState = rsUser.getString("userState");
            userPincode = rsUser.getString("userPincode");
        }
        rsUser.close();
        psUser.close();

        // Fetch cart details (make resultset scrollable so we can pre-calc total then render)
        String cartQuery = "SELECT c.cart_id, c.quantity, c.discount_price, p.prod_name, p.prod_desc, p.prod_img, p.prod_mrp " +
                           "FROM cart c JOIN products p ON c.product_id = p.prodId WHERE c.user_id=?";
        PreparedStatement psCart = con.prepareStatement(cartQuery, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        psCart.setInt(1, userId);
        ResultSet rs = psCart.executeQuery();

        // 1) First pass — calculate totalPrice
        while (rs.next()) {
            double price = rs.getDouble("discount_price");
            int quantity = rs.getInt("quantity");
            totalPrice += price * quantity;
        }

        // 2) Reset cursor to render rows below
        rs.beforeFirst();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Confirm Address - SmartHub</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #0d0d0d;
            color: #fff;
            font-family: 'Poppins', sans-serif;
        }
        .checkout-container {
            background: #1a1a1a;
            border-radius: 10px;
            padding: 30px;
            max-width: 900px;
            margin: 30px auto;
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.1);
        }
        .checkout-header h3 {
        margin-top:40px !important;
            font-weight: 600;
        }
        .delivery-option {
        	margin-top:30px !important;
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 30px;
        }
        .delivery-option button {
            background: none;
            color: white;
            border: 1px solid #555;
            padding: 10px 25px;
            border-radius: 8px;
            transition: 0.3s;
        }
        .delivery-option button.active {
            background: #007bff;
            border-color: #007bff;
        }
        .product-item {
            border-bottom: 1px solid #444;
            padding: 15px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .product-item img {
            width: 80px;
            height: 80px;
            object-fit: contain;
        }
        .product-info {
            flex: 1;
            margin-left: 20px;
        }
        .address-box {
        	background: #262626;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            p{
            	font-size:13px;
            }
        }
        .btn-primary {
        	margin-top:30px;
            background-color: #007bff;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 500;
        }
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
    <div class="Checkout-header d-flex flex-wrap align-items-center justify-content-between mb-1">
            <h2>Checkout</h2>
            <a class="text-primary text-decoration-none" href="#">Show Order Summary: <span>₹<%= String.format("%.2f", totalPrice) %></span></a>
        </div>
        <hr />
        
        <div class="checkout-header text-center mb-4">
            <h3 class="mt-3" >How would you like to get your order?</h3>
            <div class="delivery-option mt-3">
                <button class="active"><i class="bi bi-truck"></i> I'd like it delivered</button>
                <button><i class="bi bi-bag"></i> I'll pick it up</button>
            </div>
            <p class="text-secondary">Delivers to: <span class="text-info"><%= userPincode %></span></p>
        </div>

        <h5 class="mb-3">In stock and ready to ship</h5>
        
        <% while (rs.next()) {
            double price = rs.getDouble("discount_price");
            int quantity = rs.getInt("quantity");
            double subTotal = price * quantity;
            totalPrice += 0; /* already calculated above */
        %>
        <div class="product-item">
            <img src="<%= rs.getString("prod_img") %>" class="img-fluid rounded p-1" alt="<%= rs.getString("prod_name") %>">
            <div class="product-info">
                <h6><%= rs.getString("prod_name") %></h6>
                <small class="text-secondary"><%= rs.getString("prod_desc") %></small><br>
                <small class="text-secondary">Quantity: <%= quantity %></small>
            </div>
            <div class="text-end">
                <strong>₹<%= String.format("%.2f", subTotal) %></strong><br>
                <small class="text-success">Save ₹<%= String.format("%.2f", (rs.getDouble("prod_mrp") - price) * quantity) %></small>
            </div>
        </div>
        <% } %>

        <div class="address-box mt-4">
            <h5 class="mb-2 fw-bold">Delivery Address</h5>
            <p class="mb-0"><%= userName %></p>
            <p class="mb-0"><%= userAddress %>, <%= userCity %>, <%= userState %> - <%= userPincode %></p>
            <p class="mb-0">Phone: <%= userPhone %></p>
            <p><%= userEmail %></p>
        </div>

        <div class="col-lg-6 mt-4 d-flex justify-content-between align-items-center">
            <a href="payment.jsp" class="btn btn-primary w-100">Continue to Payment</a>
        </div>
    </div>

   <% 
        // cleanup
        rs.close();
        psCart.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
