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
        text-decoration:none;
     
        }
         .navbar-nav .nav-link {
    font-size: 20px; /* You can adjust this value */
    font-weight: 500; /* Optional: makes text a bit bolder */
    color: black;
  }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#"><img src="logo (1).svg" alt="Logo"></a>
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
<div class="container my-4">
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
                    <div>Up to ₹<span id="priceVal">500</span></div>
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Apply Filters</button>
            </form>

            <!-- Featured Products -->
            <h4 class="mt-4">Featured</h4>
             <div class="featured-product ">
            <img src="fruit.jpg" alt="Apple">
            <div>
              <strong>Fresh Apple</strong><br>
              <div class="product-rating">★★★★★</div>
              <span class="text-muted">$2.99</span>
            </div>
          </div>
          <div class="featured-product">
            <img src="images.jpg" alt="Almond">
            <div>
              <strong>Dryfruits</strong><br>
              <div class="product-rating">★★★★☆</div>
              <span class="text-muted">$5.49</span>
            </div>
          </div>
          <div class="featured-product">
            <img src="juice.jpg" alt="Beverages">
            <div>
              <strong>Beverages</strong><br>
              <div class="product-rating">★★★★☆</div>
              <span class="text-muted">$5.49</span>
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
            if (quantity > 0) {
        %>
            <p style="font-weight:600; color:#007bff; font-size: 1rem; margin-bottom: 10px;">
                Quantity: <span style="background-color:#e0f0ff; padding: 4px 8px; border-radius: 12px;"><%= quantity %></span>
            </p>
        <% } else { %>
            <p style="font-weight:700; color:#dc3545; font-size: 1rem; margin-bottom: 10px;">
                Out of Stock
            </p>
        <% } %>
        
        <a href="<%= prodRs.getString("link") != null ? prodRs.getString("link") : '#' %>" class="btn btn-outline-primary w-100">
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
        window.location.href = "index.html";
      });

      // Close dropdown if clicked outside
      document.addEventListener("click", function (e) {
        if (!userDropdownToggle.contains(e.target) && !userDropdownMenu.contains(e.target)) {
          userDropdownMenu.style.display = "none";
        }
      });
    });
  </script>
  
   
