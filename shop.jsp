<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
     
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
     <!-- Aos -->

     <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
     <!--  -->
    <style>
    
  
        .product-card {
            border: none;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            transition: transform 0.2s;
        }
        .product-card:hover {
            transform: scale(1.02);
        }
        .product-card img {
            border-radius: 10px;
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        .breadcrumb-nav h1 {
            font-size: 2rem;
            margin: 20px 0;
        }
        .featured-product {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .featured-product img {
            width: 100px;
            height: 100px;
            border-radius: 8px;
            margin-right: 10px;
            object-fit: cover;
        }
        .shopbreadcrumb-section {
            background: url('bg5.jpg') no-repeat center center/cover;
            height: 500px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-shadow: 0 2px 5px rgba(0, 0, 0, 0.7);
        }
        .breadcrumb-nav {
  background-color: rgba(0, 0, 0, 0.4);
  padding: 10px 20px;
  border-radius: 10px;
  font-size: 1.25rem;
}
        a{
        color:white;
        text-decoration:none !important;
     
        }
         .navbar-nav .nav-link {
    font-size: 20px; /* You can adjust this value */
    font-weight: 500; /* Optional: makes text a bit bolder */
    color: black;
  }
  .navbar-nav .nav-link:hover{
  color:green;
  }
  
  .form-range{
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
  height:7px;
  }
  
  .organic-app-section {
  
  padding: 60px 0;
  color: white;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  height: 80vh;
  padding: 20px;
  background-image: url(bg2.jpg); /* Replace with your image URL */
  background-attachment: fixed;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
  color: white;

 
}



 .fourthsection {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  height: 80vh;
  padding: 20px;
  background-image: url(banner-ad-1.jpg); /* Replace with your image URL */
  background-attachment: fixed;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
  color: white;
}
  
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.html"><img src="logo (1).svg" alt="Logo"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav gap-4">
                <li class="nav-item"><a class="nav-link" href="home.html">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
                <li class="nav-item"><a class="nav-link" href="shop.jsp">Shop</a></li>
                <li class="nav-item"><a class="nav-link" href="blog.html">Blogs</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
            </ul>
        </div>
        <div class="dropdown position-relative">
            <i class="fas fa-user fa-lg fs-2 me-3" id="userDropdownToggle" style="cursor: pointer;"></i>
            <ul class="dropdown-menu" id="userDropdownMenu" style="display:none; position:absolute; top: 40px; left: -50px; background:white; border:1px solid #ccc; border-radius:8px; min-width:160px; z-index:1000;">
                <li><span id="user-name" class="dropdown-item text-primary fw-bold text-center"></span></li>
                 <li><a class="dropdown-item" href="profile.jsp"><i class="fa-solid fa-user me-2"></i>Go to Profile</a></li>
                <li><a class="dropdown-item" href="cart.html"><i class="fa-solid fa-cart-shopping me-2"></i>Go to Cart</a></li>
                <li><a class="dropdown-item text-danger" href="#" id="logout-btn"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Mobile Navbar -->
          <nav class="navbar mobile-navbar fixed-top d-lg-none d-block bg-white shadow-sm">
            <div class="container">
              <a class="navbar-brand" href="#"><img src="logo (1).svg" alt="Logo"></a>
              <button class="navbar-toggler custom-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar">
                <div class="offcanvas-header">
                  <h5 class="offcanvas-title">
                    <img src="logo (1).svg" alt="Logo" height="30">
                  </h5>
                  <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                 <ul class="navbar-nav text-center">
                <li class="nav-item border-bottom border-dark"><a class="nav-link" href="home.html">Home</a></li>
                <li class="nav-item border-bottom border-dark"><a class="nav-link" href="about.html">About</a></li>
                <li class="nav-item border-bottom border-dark"><a class="nav-link" href="shop.jsp">Shop</a></li>
                <li class="nav-item border-bottom border-dark"><a class="nav-link" href="blog.html">Blogs</a></li>
                <li class="nav-item border-bottom border-dark"><a class="nav-link" href="contact.html">Contact</a></li>
             </ul>
                </div>
              </div>
            </div>
          </nav>
<!-- Breadcrumb -->
<div class="container-fluid shopbreadcrumb-section mt-5 pt-5">
    <nav class="breadcrumb-nav text-center" >
        <h1>Shop</h1>
        <a href="#">Home</a> / <a href="#">Shop</a>
    </nav>
</div>

<!-- Main Content -->
<div class="container-fluid my-4">
    <div class="row">
        <!-- Filters Section -->
        <div class="col-lg-3 col-md-4 col-sm-12 mb-4">
            <form id="filterForm">
                <div class="mb-3">
                    <input type="text" name="search" class="form-control" placeholder="Search Products">
                </div>
                <div class="mb-3">
                    <h5>Categories</h5>
                    <%
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                        Statement catStmt = con.createStatement();
                        ResultSet catRs = catStmt.executeQuery("SELECT * FROM categories");
                        while (catRs.next()) {
                    %>
                        <div class="form-check">
                            <input class="form-check-input category-filter" type="checkbox" name="category" value="<%= catRs.getInt("category_id") %>">
                            <label class="form-check-label"><%= catRs.getString("category_name") %></label>
                        </div>
                    <%
                        }
                        catRs.close();
                        catStmt.close();
                    %>
                </div>
                <div class="mb-3">
                    <h5>Price Range</h5>
                    <input type="range" class="form-range" min="0" max="500" name="price" step="10" id="priceRange">
                    <div class="d-flex justify-content-between"><span class="priceVal">₹0</span><span>₹500</span></div>
                   
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Apply Filters</button>
            </form>

            <!-- Featured Products -->
            <h4 class="mt-4">Featured</h4>
             <div class="featured-product ">
            <img src="orfruit.jpg" alt="Apple">
            <div>
              <strong>Fresh Fruits</strong><br>
              <div class="product-rating">★★★★★</div>
              <span class="text-muted">Rs 300</span>
            </div>
          </div>
          
          <div class="featured-product">
            <img src="images.jpg" alt="Almond">
            <div>
              <strong>Dryfruits</strong><br>
              <div class="product-rating">★★★★☆</div>
              <span class="text-muted">Rs 350</span>
            </div>
          </div>
          
          <div class="featured-product">
            <img src="juice.jpg" alt="Beverages">
            <div>
              <strong>Beverages</strong><br>
              <div class="product-rating">★★★★☆</div>
              <span class="text-muted">Rs 180</span>
            </div>
          </div>
          
          <div class="featured-product">
            <img src="shop.jpg" alt="Beverages">
            <div>
              <strong>Vegitables</strong><br>
              <div class="product-rating">★★★★☆</div>
              <span class="text-muted">Rs 200</span>
            </div>
          </div>
          
        </div>

        <!-- Products Section -->
        <div class="col-lg-9 col-md-8 col-sm-12">
            <div class="row" id="productContainer">
                <%
                    String search = request.getParameter("search");
                    String[] categories = request.getParameterValues("category");
                    String price = request.getParameter("price");

                    StringBuilder query = new StringBuilder("SELECT * FROM products WHERE 1=1");
                    if (search != null && !search.trim().isEmpty()) {
                        query.append(" AND name LIKE '%").append(search).append("%'");
                    }
                    if (categories != null && categories.length > 0) {
                        query.append(" AND category_id IN (");
                        for (int i = 0; i < categories.length; i++) {
                            query.append(categories[i]);
                            if (i < categories.length - 1) {
                                query.append(",");
                            }
                        }
                        query.append(")");
                    }
                    if (price != null && !price.isEmpty()) {
                        query.append(" AND price <= ").append(price);
                    }

                    Statement prodStmt = con.createStatement();
                    ResultSet prodRs = prodStmt.executeQuery(query.toString());
                    while (prodRs.next()) {
                %>
                    <div class="col-md-4"> 
    <div class="product-card">
        <img src="<%= prodRs.getString("image") %>" alt="Product" class="img-fluid">
        <h5 class="mt-2"><%= prodRs.getString("name") %></h5>
        <p><%= prodRs.getString("description") %></p>
        <p class="text-success fw-bold">₹<%= prodRs.getDouble("price") %></p>
        
        <%
    int quantity = prodRs.getInt("quantity");
    boolean inStock = quantity > 0;
%>

<% if (inStock) { %>
    <p style="font-weight:600; color:#007bff; font-size: 1rem; margin-bottom: 10px;">
        Quantity: <span style="background-color:#e0f0ff; padding: 4px 8px; border-radius: 12px;"><%= quantity %> avl</span>
    </p>
<% } else { %>
    <p style="font-weight:700; color:#dc3545; font-size: 1rem; margin-bottom: 10px;">
        Out of Stock
    </p>
<% } %>

<a 
    href="<%= inStock ? prodRs.getString("link") : "#" %>" 
    class="btn btn-outline-primary w-100 <%= !inStock ? "disabled" : "" %>" 
    <%= !inStock ? "tabindex='-1' aria-disabled='true'" : "" %>>
    View Details
</a>
        
    </div>
</div>    
                <%
                    }
                    prodRs.close();
                    prodStmt.close();
                    con.close();
                %>
            </div>
        </div>
    </div>
</div>

<!-- download section -->
  <section class="organic-app-section container-fluid">
    <div class="container-fluid">
      <div class="row align-items-center">

        <!-- Left Side -->
        <div class="col-md-6">
          <div class="organic-text-box">
            <h2>Download Organic App</h2>
            <p>Stay healthy, shop fresh – Anytime, Anywhere.</p>
            <div class="store-buttons">
              <a href="#"><img src="img-app-store.png" class="mb" alt="App Store"></a>
              <a href="#"><img src="img-google-play.png" alt="Play Store"></a>

            </div>
          </div>
        </div>

        <!-- Right Side -->
        <div class="col-md-6 text-center">
          <!-- <img src="//banner-onlineapp.png" alt="App Promo" class="img-fluid big-img"> -->
        </div>

      </div>
    </div>
  </section>


  <!--  -->



  <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
    <div class="container py-5" >
      <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
        <div class="row g-4">
          <div class="col-lg-3">
            <a href="#">
              <a class="navbar-brand" href="#"><img src="logo (1).svg" alt="Logo"></a>
            </a>
          </div>
          <div class="col-lg-6">
            <div class="position-relative mx-auto">
              <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="number" placeholder="Your Email">
              <button type="submit"
                class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                style="top: 0; right: 0;">Subscribe Now</button>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="d-flex justify-content-end pt-3">
              <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                  class="fab fa-twitter"></i></a>
              <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                  class="fab fa-facebook-f"></i></a>
              <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i
                  class="fab fa-youtube"></i></a>
              <a class="btn btn-outline-secondary btn-md-square rounded-circle" href=""><i
                  class="fab fa-linkedin-in"></i></a>
            </div>
          </div>
        </div>
      </div>
      <div class="row g-5">
        <div class="col-lg-3 col-md-6">
          <div class="footer-item">
            <h4 class="text-light mb-3">Why People Like us!</h4>
            <p class="mb-4">

We offers fresh, chemical-free products with quality, purity, and care—supporting healthy living, eco-friendly choices, and transparency that builds trust and promotes sustainability naturally.
            </p>
            <a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read More</a>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="d-flex flex-column text-start footer-item">
            <h4 class="text-light mb-3">Shop Info</h4>
            <a class="btn-link" href="">About Us</a>
            <a class="btn-link" href="">Contact Us</a>
            <a class="btn-link" href="">Privacy Policy</a>
            <a class="btn-link" href="">Terms & Condition</a>
            <a class="btn-link" href="">Return Policy</a>
            <a class="btn-link" href="">FAQs & Help</a>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="d-flex flex-column text-start footer-item">
            <h4 class="text-light mb-3">Account</h4>
            <a class="btn-link" href="">My Account</a>
            <a class="btn-link" href="">Shop details</a>
            <a class="btn-link" href="">Shopping Cart</a>
            <a class="btn-link" href="">Wishlist</a>
            <a class="btn-link" href="">Order History</a>
            <a class="btn-link" href="">International Orders</a>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="footer-item">
            <h4 class="text-light mb-3">Contact</h4>
            <p>Address: 1429 Ravi Nagar, Amaravati 48247</p>
            <p>Email: Example@gmail.com</p>
            <p>Phone: +0123 4567 8910</p>
            <p>Payment Accepted</p>
            <img src="payment.png" class="img-fluid" alt="">
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer End -->

  <!-- Copyright Start -->
  <div class="container-fluid copyright bg-dark py-4">
    <div class="container">
      <div class="row">
        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
          <span class="text-light"><a href="index.html"><i class="fas fa-copyright text-light me-2"></i>2025</a>, All
            right reserved.</span>
        </div>
        <div class="col-md-6 my-auto text-center text-md-end text-white">
          <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
          <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
          <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
          Designed By <a class="border-bottom" href="index.html">Aditya</a>
        </div>
      </div>
    </div>
  </div>
  <!-- Copyright End -->
<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
  
 
<script>


    // Toggle user dropdown
    document.getElementById('userDropdownToggle')?.addEventListener('click', function () {
        const menu = document.getElementById('userDropdownMenu');
        menu.style.display = (menu.style.display === 'none') ? 'block' : 'none';
    });

    // Update price value display
    document.getElementById('priceRange')?.addEventListener('input', function () {
        document.getElementById('priceVal').textContent = this.value;
    });

    <script>
    document.addEventListener("DOMContentLoaded", function () {
      const userIcon = document.getElementById("user-icon");
      const userDropdown = document.getElementById("user-dropdown");
      const userNameDisplay = document.getElementById("user-name");
      const username = sessionStorage.getItem("username");

      if (username) {
        userNameDisplay.textContent = username;
        userDropdown.style.display = "block";
      } else {
        userDropdown.style.display = "none";
      }

      userIcon.addEventListener("click", () => {
        document.getElementById("dropdown-menu").classList.toggle("show");
      });

      document.getElementById("logout-btn").addEventListener("click", () => {
        sessionStorage.removeItem("username");
        window.location.href = "login.html";
      });
    });
  </script>
  
 
    
    <script>
    document.addEventListener("DOMContentLoaded", function () {
      const userIcon = document.getElementById("user-icon");
      const userDropdown = document.getElementById("user-dropdown");
      const userNameDisplay = document.getElementById("user-name");
      const username = sessionStorage.getItem("username");

      if (username) {
        userNameDisplay.textContent = username;
        userDropdown.style.display = "block";
      } else {
        userDropdown.style.display = "none";
      }

      userIcon.addEventListener("click", () => {
        document.getElementById("dropdown-menu").classList.toggle("show");
      });

      document.getElementById("logout-btn").addEventListener("click", () => {
        alert("Logging off...");
        sessionStorage.removeItem("username");
        window.location.href = "index.html";
      });
    });
  </script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
      const userDropdownToggle = document.getElementById("userDropdownToggle");
      const userDropdownMenu = document.getElementById("userDropdownMenu");
      const userNameDisplay = document.getElementById("user-name");
      const logoutBtn = document.getElementById("logout-btn");

      const username = sessionStorage.getItem("username");

      if (username) {
        userNameDisplay.textContent = username;
      } else {
        userDropdownMenu.innerHTML = '<li class="dropdown-item text-muted">Not logged in</li>';
      }

      userDropdownToggle.addEventListener("click", function () {
        userDropdownMenu.style.display = userDropdownMenu.style.display === "block" ? "none" : "block";
      });

      logoutBtn?.addEventListener("click", function () {
  	    alert("Logging off...");
  	    sessionStorage.removeItem("username");
  	    window.location.replace("index.html");
  	  });

      // Close dropdown if clicked outside
      document.addEventListener("click", function (e) {
        if (!userDropdownToggle.contains(e.target) && !userDropdownMenu.contains(e.target)) {
          userDropdownMenu.style.display = "none";
        }
      });
    });
  </script>
  
   

   