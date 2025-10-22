<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Shop - Smartphones</title>

        <!-- CSS -->
        <link rel="stylesheet" href="CSS/style.css">

        <!-- Icons -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
            rel="stylesheet">

        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
    body {
        background-color: #f9f9f9;
        font-family: 'Inter', sans-serif;
        color: #333;
    }
    .search-bar {
        border-radius: 25px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        border: 1px solid #ddd;
        padding: 8px 15px;
        width: 100%;
    }
    
    
    /* Remove border & background */
.form-select {
    border: none !important;       /* removes the border */
    box-shadow: none !important;   /* removes focus outline shadow */
    background-color: transparent; /* optional: makes it blend in */
            /* adjust spacing for arrow */
}

/* Move arrow closer to text */
.form-select {
    background-position:left 4.5rem center; /* moves arrow closer */
    background-size: 12px;                    /* resize arrow if needed */
}

/* Optional: keep hover/focus clean */
.form-select:focus {
    border: none;
    box-shadow: none;
}




    .filter-bar {
        background: #fff;
        border-radius: 50px;
        padding: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 20px;
    }
    .product-card {
        /* background: #fff; */
        border-radius: 16px;
        
        text-align: center;
        transition: 0.3s;
        
    }
    
    .card-body p{
    margin-top:5px;
    font-size:13px ;
    }
    .card-text{
    margin:0;
    }
    .product-card img:hover {
    transform: scale(1.2);
        
        box-shadow: 0 8px 24px rgba(0,0,0,0.1);
    }
    .product-card img {
        max-width: 40%;
        border-radius: 12px;
        transition: all 0.3s ease-in-out;
    }
    .btn-apply{
        background: rgba(0, 0, 0, 0.906) ;
        border: none;
        color: white;
        border-radius: 5px;
        padding: 6px 16px;
        transition: 0.3s;
    }
    .btn-custom:hover {
        background: #0056b3;
    }
    .wishlist-icon {
        position: absolute;
        top: 10px;
        right: 15px;
        font-size: 20px;
        color: #bbb;
        cursor: pointer;
    }
    .wishlist-icon:hover {
        color: red;
    }
    .product-card-img-area {
    background: #e9ecef; /* light gray */
     border-radius: 16px;
    padding: 50px 0; 
    text-align: center;
}

.product-card .card-body {
    background: rgba(255, 255, 255, 0) !important; /* transparent white */
    border-bottom-left-radius: 16px;
    border-bottom-right-radius: 16px;
    margin-top: 0;
    padding: 16px;
}



.glass-white {
    background: rgba(255, 255, 255, 0.55); /* semi-transparent white */
    backdrop-filter: blur(15px) saturate(180%);
    -webkit-backdrop-filter: blur(15px) saturate(180%);
    border-radius: 16px;
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
    color: #000; /* ensure text stays dark */
}

.glass-white h5, 
.glass-white p, 
.glass-white strong {
    color: #000; /* readable text */
}


/* Glass effect modal */
.glass-white {
    background: rgba(255, 255, 255, 0.55);
    backdrop-filter: blur(15px) saturate(180%);
    -webkit-backdrop-filter: blur(15px) saturate(180%);
    border-radius: 16px;
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
    color: #000;
}

/* Storage buttons */
.btn-outline-dark,
.btn-outline-primary,
.btn-outline-secondary {
    font-size: 0.9rem;
    border-radius: 8px;
    padding: 8px 12px;
    text-align: left;
}

/* Active storage button */
.btn-outline-primary.active {
    border: 2px solid #0d6efd;
}

/* Colour circles */
/* .color-circle {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    margin-bottom: 5px;
} */

/* Active storage button */
.storage-option.active {
    border: 2px solid #0d6efd !important;
    background: #e7f1ff00;
}

/* Color circles */
.color-circle {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    margin-bottom: 5px;
    cursor: pointer;
    transition: 0.2s;
}

.color-circle.active {
    border: 3px solid #0d6efd;
    box-shadow: 0 0 8px rgba(0,0,0,0.2);
}

</style>
    </head>
    <body>
        <section class="header">
            <nav class="navbar navbar-expand-lg">
                <div class="container">
                    <a class="navbar-brand text-white fw-bold gradient-heading"
                        href="#">

                        SmartHub
                    </a>
                    <div class="collapse navbar-collapse justify-content-center"
                        id="navbarSupportedContent">
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
                                <a class="nav-link"
                                    href="./contact.jsp">CONTACT</a>
                            </li>
                        </ul>
                    </div>
                    <div class="d-flex align-items-center">
                        <ul class="navbar-nav flex-row">
                            <li class="nav-item px-2">
                                <a class="nav-link" href="#"><i
                                        class="bi bi-search"></i></a>
                            </li>
                            <!-- 
                        <li class="nav-item px-2">
                            <a class="nav-link" href="logIn.jsp"><i class="bi bi-person"></i></a>
                        </li>
                         -->
                            <li class="nav-item px-2">
                                <a class="nav-link" href="#"><i
                                        class="bi bi-heart"></i></a>
                            </li>
                            <li class="nav-item px-2">
                                <a class="nav-link" href="./cart.jsp"><i
                                        class="bi bi-bag"></i></a>
                            </li>
                            <li class="nav-item px-2"><a class="nav-link"
                                    href="LogoutServlet"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="bottom"
                                    title="<%= session.getAttribute("userName")
                                    %>">
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

        <div class="container mt-4">

            <!-- 🔎 Search & Filter Bar -->
            <div class="filter-bar row align-items-center mb-3">
                <div class=" col-md-4 ">
                    <input type="text" class="search-bar"
                        placeholder="Search for iPhone, Galaxy...">
                </div>
                <div class="col-md-5 col-sm-12 d-flex">
                    <div class="product-filter col-md-4 ">
                        <select class="form-select">
                            <option>Brand</option>
                            <option>Apple</option>
                            <option>Samsung</option>
                            <option>OnePlus</option>
                            <option>Google</option>
                        </select>
                    </div>
                    <div class="product-filter col-md-4 ">
                        <select class="form-select">
                            <option>Storage</option>
                            <option>128GB</option>
                            <option>256GB</option>
                            <option>512GB</option>
                        </select>
                    </div>
                    <div class="product-filter col-md-4 ">
                        <select class="form-select">
                            <option>Sort by</option>
                            <option>Price: Low → High</option>
                            <option>Price: High → Low</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-2 ">
                    <button class="btn-apply  w-100">Apply Filters</button>
                </div>
            </div>

            <!-- 📱 Product Grid -->
            <div class="row g-4">
                <!-- Example Product -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card position-relative">
                        <div class="product-card-img-area">
                            <img src="./Assets/Imges/mobiles/iphone14.png"
                                class="card-img-top" alt="iPhone 15 Pro"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal1">
                        </div>
                        <!-- Card Body -->
                        <div class="card-body text-start mt-0">
                            <h6 class="card-title fw-bold fs-5">iPhone 15
                                Pro</h6>
                            <p class="card-text">256GB | A17 Pro | 6.1"</p>
                            <p class="card-text mt-3">MRP (Inclusive of all
                                taxes) <br>
                                <del class="text-black">₹ 1,29,999.00</del>
                                <span class="text-primary fw-bold">Save
                                    ₹19,999.00</span>
                            </p>
                            <p class="card-text fw-bold fs-5">₹1,20,000.00</p>
                            <p>No Cost EMI starts from ₹912.18/ month</p>
                            <button class="btn btn-outline-dark btn-sm mt-2"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal1">
                                View Details
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Another Product -->

            </div>

            <!-- 📑 Pagination -->
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled"><a
                            class="page-link">Previous</a></li>
                    <li class="page-item active"><a class="page-link">1</a></li>
                    <li class="page-item"><a class="page-link">2</a></li>
                    <li class="page-item"><a class="page-link">3</a></li>
                    <li class="page-item"><a class="page-link">Next</a></li>
                </ul>
            </nav>

        </div>

        <!-- 🔍 Product Quick View Modal (iPhone 15 Pro) -->
        <!-- 🔍 Product Quick View Modal (iPhone 15 Pro) -->
        <div class="modal fade" id="productModal1" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content glass-white">
                    <div class="modal-header border-0">
                        <h5 class="fw-bold">iPhone 15 Pro</h5>
                        <button type="button" class="btn-close"
                            data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body row">

                        <!-- Product Image -->
                        <div class="col-md-4 px-4">
                            <img src="./Assets/Imges/mobiles/iphone14.png"
                                class="card-img-top img-fluid"
                                alt="iPhone 15 Pro">
                        </div>

                        <!-- Product Info -->
                        <div class="col-md-8">
                            <p id="specs"><strong>Specs:</strong> <span>256GB |
                                    A17 Pro | 6.1"</span></p>
                            <p id="price"><strong>Price:</strong>
                                ₹<span>120000</span></p>
                            <p class="card-text mt-2">
                                MRP (Inclusive of all taxes) <br>
                                <del class="text-muted">₹1,29,999.00</del>
                                <span class="text-primary fw-bold"> Save
                                    ₹19,999.00</span>
                            </p>
                            <p><strong>Offers:</strong> 10% Bank Discount | EMI
                                from ₹5000/mo</p>

                            <!-- Storage Options -->
                            <div class="mt-3">
                                <h6><strong>Storage</strong></h6>
                                <div class="d-flex flex-column gap-2"
                                    id="storage-options">
                                    <button
                                        class="btn btn-outline-secondary disabled text-muted">128
                                        GB | 12 GB</button>

                                    <button
                                        class="btn btn-outline-dark storage-option d-flex justify-content-between"
                                        data-price="110999"
                                        data-storage="256GB | 12GB">
                                        256 GB | 12 GB <span>₹110999.00</span>
                                    </button>
                                    <button
                                        class="btn btn-outline-dark storage-option d-flex justify-content-between active"
                                        data-price="121999"
                                        data-storage="512GB | 12GB">
                                        512 GB | 12 GB <span>₹121999.00</span>
                                    </button>
                                </div>
                            </div>

                            <!-- Color Options -->
                            <div class="mt-3">
                                <h6><strong>Colour</strong></h6>
                                <div class="d-flex gap-3" id="color-options">
                                    <div class="text-center">
                                        <div
                                            class="color-circle bg-secondary color-option"
                                            data-color="Gray"></div>
                                        <small>Gray</small>
                                    </div>
                                    <div class="text-center">
                                        <div
                                            class="color-circle bg-light border color-option active"
                                            data-color="Silver"></div>
                                        <small>Silver</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Delivery Pincode -->
                            <div class="mt-3">
                                <h6><strong>Delivery Details</strong></h6>
                                <div class="input-group"
                                    style="max-width: 250px;">
                                    <input type="text" class="form-control"
                                        placeholder="Enter Pincode"
                                        id="pincode">
                                    <button
                                        class="btn btn-outline-primary">Check</button>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="mt-4">
                                <button class="btn btn-outline-danger">❤️ Add to
                                    Wishlist</button>
                                <button class="btn btn-success"
                                    id="addToCartBtn">Add to Cart</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for Galaxy S24 Ultra -->

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



        <script>
document.addEventListener("DOMContentLoaded", () => {
  let selectedStorage = "512GB | 12GB";
  let selectedPrice = 121999;
  let selectedColor = "Silver";

  // Handle storage selection
  document.querySelectorAll(".storage-option").forEach(btn => {
    btn.addEventListener("click", function() {
      document.querySelectorAll(".storage-option").forEach(b => b.classList.remove("active"));
      this.classList.add("active");

      selectedStorage = this.getAttribute("data-storage");
      selectedPrice = this.getAttribute("data-price");

      document.querySelector("#specs span").textContent = selectedStorage + " | A17 Pro | 6.1\"";
      document.querySelector("#price span").textContent = selectedPrice;
    });
  });

  // Handle color selection
  document.querySelectorAll(".color-option").forEach(circle => {
    circle.addEventListener("click", function() {
      document.querySelectorAll(".color-option").forEach(c => c.classList.remove("active"));
      this.classList.add("active");
      selectedColor = this.getAttribute("data-color");
    });
  });

  // Handle Add to Cart
  document.getElementById("addToCartBtn").addEventListener("click", () => {
    alert(`🛒 Added to cart: iPhone 15 Pro\nStorage: ${selectedStorage}\nColor: ${selectedColor}\nPrice: ₹${selectedPrice}`);
  });
});
</script>

    </body>
</html>
