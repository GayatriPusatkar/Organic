<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
%>
    <script>
        alert("⚠️ Please log in first.");
        window.location.href = "login.html";
    </script>
<%
        return;
    }

    String url = "jdbc:mysql://localhost:3306/organic_shop";
    String dbUser = "root";
    String dbPass = "root";
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    String fullName = "", email = "", password = "";
    boolean updated = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            fullName = request.getParameter("full_name");
            email = request.getParameter("email");
            password = request.getParameter("password");

            pst = conn.prepareStatement("UPDATE users SET full_name=?, email=?, password=? WHERE username=?");
            pst.setString(1, fullName);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, username);
            pst.executeUpdate();
            updated = true;
        }

        pst = conn.prepareStatement("SELECT * FROM users WHERE username=?");
        pst.setString(1, username);
        rs = pst.executeQuery();
        if (rs.next()) {
            fullName = rs.getString("full_name");
            email = rs.getString("email");
            password = rs.getString("password");
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="demo.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #fff);
        }
        .profile-container {
            max-width: 900px;
            margin: auto;
            margin-top: 50px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-header h2 {
            font-weight: bold;
        }
        .user-icon {
            font-size: 60px;
            color: #4caf50;
            margin-bottom: 10px;
        }
        .table thead {
            background-color: #c8e6c9;
        }
    </style>
</head>
<body>
<div class="container-fluid firstparent">
        <div class="container-fluid first">
          <!-- Desktop Navbar -->
          <nav class="navbar navbar-expand-lg d-lg-block d-none bg-white shadow-sm fixed-top">
            <div class="container">
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
        </div>
      
        
        
      </div>

<div class="container profile-container">
    <div class="profile-header">
        
        <h2>👤 Edit Profile</h2>
    </div>

    <form method="post">
        <input type="hidden" name="username" value="<%= username %>">
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" class="form-control" name="full_name" value="<%= fullName %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" class="form-control" name="email" value="<%= email %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="text" class="form-control" name="password" value="<%= password %>" required>
        </div>
        <button type="submit" class="btn btn-success w-100"><i class="fas fa-save me-1"></i> Update Profile</button>
    </form>

    <hr class="my-4">

    <h4 class="text-primary"><i class="fas fa-history me-2"></i>🧾 Order History</h4>
    <div class="table-responsive">
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>🛒 Product</th>
                    <th>💰 Price</th>
                    <th>🔢 Quantity</th>
                    <th>📅 Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                pst = conn.prepareStatement("SELECT product_name, price, quantity, order_date FROM orders WHERE username=?");
                pst.setString(1, username);
                rs = pst.executeQuery();
                boolean hasOrders = false;
                while (rs.next()) {
                    hasOrders = true;
            %>
                <tr>
                    <td><%= rs.getString("product_name") %></td>
                    <td>₹<%= rs.getDouble("price") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getTimestamp("order_date") %></td>
                </tr>
            <%
                }
                if (!hasOrders) {
            %>
                <tr>
                    <td colspan="4" class="text-center text-danger">No orders found!</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Toast -->
<div id="profileToast" class="toast bg-success text-white" role="alert" data-bs-delay="3000" data-bs-autohide="true">
  <div class="toast-body">
    ✅ Profile updated successfully!
  </div>
</div>


<script>
    const storedUsername = sessionStorage.getItem("username");
    if (storedUsername) {
        document.getElementById("displayUsername").textContent = storedUsername;
    } else {
        alert("⚠️ Session expired. Please log in again.");
        window.location.href = "login.html";
    }

    

</script>

<% if (updated) { %>
<script>
  alert("✅ Profile updated successfully!");
</script>
<% } %>


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
 

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>
