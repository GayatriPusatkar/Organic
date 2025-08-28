<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String msg = "";
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("action") != null && request.getParameter("action").equals("addtocart")) {
        String productName = request.getParameter("product_name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = 1;

        String username = (String) session.getAttribute("username");

        if (username != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                String sql = "INSERT INTO cart (username, product_name, price, quantity) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, productName);
                ps.setDouble(3, price);
                ps.setInt(4, quantity);
                ps.executeUpdate();
                msg = "Product added to cart!";
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                msg = "Error adding to cart!";
            }
        } else {
            msg = "Please login first!";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <!-- head content as-is -->
  
  <head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Organic Apple</title>
  <link rel="stylesheet" href="assets/CSS/product.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
      const userIcon = document.getElementById("userDropdownToggle");
      const userMenu = document.getElementById("userDropdownMenu");

      if (userIcon) {
        userIcon.addEventListener("click", () => {
          userMenu.style.display = userMenu.style.display === "none" ? "block" : "none";
        });
      }

      const username = sessionStorage.getItem("username");
      if (username) {
        document.getElementById("user-name").textContent = username;
      }

      const logoutBtn = document.getElementById("logout-btn");
      if (logoutBtn) {
        logoutBtn.addEventListener("click", () => {
          sessionStorage.clear();
          window.location.href = "login.html";
        });
      }
    });
  </script>
  <style>
    .show-on-click {
      display: none;
    }
    .dropdown:hover .show-on-click {
      display: block;
    }
    .product-page {
      padding-top: 100px;
    }
  </style>
</head>
<body>
  <!-- navbar and all content as-is -->
  
  <!-- ✅ Navbar Section -->
  <div class="container-fluid firstparent">
    <div class="container-fluid first">
      <nav class="navbar navbar-expand-lg d-lg-block d-none">
        <div class="container bg-white shadow-sm fixed-top">
          <a class="navbar-brand" href="#"><img src="logo (1).svg" alt="Logo"></a>
          <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto gap-4">
              <li class="nav-item"><a class="nav-link" href="home.html">Home</a></li>
              <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
              <li class="nav-item"><a class="nav-link" href="shop.jsp">Shop</a></li>
              <li class="nav-item"><a class="nav-link" href="blog.html">Blogs</a></li>
              <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>
            </ul>
          </div>
          <div class="dropdown position-relative">
            <i class="fas fa-user fa-lg fs-2 me-3" id="userDropdownToggle" style="cursor: pointer;"></i>
            <ul class="dropdown-menu show-on-click" id="userDropdownMenu" style="display:none; position:absolute; top: 40px; left: -50px; background:white; border:1px solid #ccc; border-radius:8px; min-width:160px; z-index:1000;">
              <li><span id="user-name" class="dropdown-item text-primary fw-bold text-center"></span></li>
              <li><a class="dropdown-item" href="cart.html"><i class="fa-solid fa-cart-shopping me-2"></i>Go to Cart</a></li>
              <li><a class="dropdown-item text-danger" href="#" id="logout-btn"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a></li>
            </ul>
          </div>
        </div>
      </nav>

      <nav class="navbar mobile-navbar fixed-top d-lg-none d-block bg-white shadow-sm">
        <div class="container">
          <a class="navbar-brand" href="#"><img src="logo (1).svg" alt="Logo"></a>
          <button class="navbar-toggler custom-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar">
            <div class="offcanvas-header">
              <h5 class="offcanvas-title"><img src="logo (1).svg" alt="Logo" height="30"></h5>
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
    </div>
  </div>
  

  <!-- ✅ Product Section -->
  <section class="product-page">
    <div class="container">
      <div class="product-image">
        <img src="apple.jpg" alt="Organic Apple" />
      </div>
      <div class="product-details">
        <h1>Organic Apples</h1>
        <p class="tagline">Crisp, Juicy, and Naturally Sweet</p>
        <p class="description">
          Our Organic Apples are grown without synthetic pesticides or fertilizers. Packed with antioxidants and vitamins, they make the perfect healthy snack.
        </p>
        <ul class="info-list">
          <li><strong>Price:</strong> ₹120 / 1 Kg</li>
          <li><strong>Type:</strong> Fuji (Certified Organic)</li>
          <li><strong>Ripening:</strong> Naturally Ripened</li>
          <li><strong>Packaging:</strong> Eco-Friendly Box</li>
        </ul>
        <div class="buttons">
          <form method="post" style="display:inline;">
            <input type="hidden" name="action" value="addtocart" />
            <input type="hidden" name="product_name" value="Organic Apple" />
            <input type="hidden" name="price" value="120" />
            <button type="submit" class="add-cart">Add to Cart</button>
          </form>
          <button class="buy-now" onclick="buyNow()">Buy Now</button>
        </div>
        <% if (!msg.equals("")) { %>
          <div class="alert alert-info mt-3"><%= msg %></div>
        <% } %>
      </div>
    </div>

    <!-- quality check as-is -->
    <div class="quality-check">
      <h2>Quality Checks</h2>
      <table>
        <thead>
          <tr>
            <th>Parameter</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>100% Organic</td>
            <td>✔ Certified</td>
          </tr>
          <tr>
            <td>Pesticide-Free</td>
            <td>✔ Grown Without Chemicals</td>
          </tr>
          <tr>
            <td>Freshness</td>
            <td>✔ Handpicked Weekly</td>
          </tr>
          <tr>
            <td>Packaging</td>
            <td>✔ Eco-Friendly</td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>

  <script>
    function buyNow() {
      const product = {
        id: 1,
        name: "Organic Apple",
        price: 120,
        quantity: 1,
        image: "apple.jpg"
      };
      localStorage.setItem("order", JSON.stringify(product));
      window.location.href = "placeorder.jsp?id=" + product.id;
    }
  </script>
</body>
</html>
