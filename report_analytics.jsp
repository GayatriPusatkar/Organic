<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>📦 Orders & Insights</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
 
   
    <style>
           body, html {
      height: 100%;
      margin: 0;
      font-family: 'Arial', sans-serif;
    }
    .sidebar {
      height: 100vh;
      width: 250px;
      position: fixed;
      top: 0;
      left: 0;
      background: linear-gradient(to bottom, #2e7d32, #1b5e20);
      color: white;
      padding-top: 60px;
      z-index: 1000;
    }
    .sidebar h4 {
      text-align: center;
      font-weight: bold;
      margin-bottom: 20px;
      background-color: #388e3c;
      padding: 10px;
      border-bottom: 3px solid #66bb6a;
    }
    .sidebar a {
      display: block;
      color: white;
      padding: 15px;
      text-decoration: none;
    }
    .sidebar a:hover {
      background-color: rgba(255, 255, 255, 0.15);
    }
    .sidebar .logout {
      margin-top: auto;
    }
    .content {
      margin-left: 250px;
      padding: 20px;
      min-height: 100vh;
      background-color: #f8f9fa;
    }
        @media (max-width: 768px) {
            .sidepanel {
                display: none;
            }
            .content {
                margin-left: 0;
            }
        }
        .summary-box {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .summary-icon {
            font-size: 2rem;
            margin-right: 10px;
        }
    </style>
</head>
<body>

<!-- Side Panel -->

<!-- Offcanvas Navbar (Only for small screens) -->
<nav class="navbar navbar-dark bg-success d-md-none">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <span class="navbar-brand">Admin Panel</span>
  </div>
</nav>

<!-- Offcanvas Sidebar -->
<div class="offcanvas offcanvas-start text-bg-success" tabindex="-1" id="offcanvasMenu">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Menu</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <a href="admindashboard.html" class="d-block text-white py-2"><i class="fas fa-home"></i> Home</a>
    <a href="product_management.jsp" class="d-block text-white py-2"><i class="fas fa-box"></i> Product Management</a>
    <a href="user_management.jsp" class="d-block text-white py-2"><i class="fas fa-users"></i> User Management</a>
    <a href="report_analytics.jsp" class="d-block text-white py-2"><i class="fas fa-chart-line"></i> Orders & Insights</a>
    <a href="admin_settings.jsp" class="d-block text-white py-2"><i class="fas fa-cog"></i> Admin Settings</a>
     
    <a href="index.html" class="d-block text-white py-2" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </div>
</div>

<div class="sidebar d-none d-md-block">
  <h4>Admin Panel</h4>
  <a href="admindashboard.html"><i class="fas fa-home"></i> Home</a>
  <a href="product_management.jsp"><i class="fas fa-box"></i> Product Management</a>
  <a href="user_management.jsp"><i class="fas fa-users"></i> User Management</a>
  <a href="report_analytics.jsp"><i class="fas fa-chart-line"></i> Orders & Insights</a>
  <a href="admin_settings.jsp"><i class="fas fa-cog"></i> Admin Settings</a>
  <a href="feedbacks.jsp"><i class="fas fa-comments"></i> User Feedback</a>
  
  <a href="index.html" class="logout" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>



<!-- Main Content -->
<div class="content">
    <h2 class="mb-4">📦 Orders & Insights</h2>

    <!-- Summary Stats -->
    <div class="row g-4 mb-4">
        <%
            int totalOrders = 0;
            double totalRevenue = 0.0;
            int totalQuantity = 0;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS totalOrders, SUM(price * quantity) AS totalRevenue, SUM(quantity) AS totalQty FROM orders");
                if (rs.next()) {
                    totalOrders = rs.getInt("totalOrders");
                    totalRevenue = rs.getDouble("totalRevenue");
                    totalQuantity = rs.getInt("totalQty");
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error fetching summary: " + e.getMessage() + "</div>");
            }
        %>
        <div class="col-md-4">
            <div class="summary-box d-flex align-items-center">
                <i class="bi bi-cart-check-fill summary-icon text-primary"></i>
                <div>
                    <h5>Total Orders 🛒</h5>
                    <h4><%= totalOrders %></h4>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="summary-box d-flex align-items-center">
                <i class="bi bi-currency-rupee summary-icon text-success"></i>
                <div>
                    <h5>Total Revenue 💰</h5>
                    <h4>₹ <%= totalRevenue %></h4>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="summary-box d-flex align-items-center">
                <i class="bi bi-box-seam summary-icon text-warning"></i>
                <div>
                    <h5>Total Quantity Sold 📦</h5>
                    <h4><%= totalQuantity %></h4>
                </div>
            </div>
        </div>
    </div>

   <!-- Orders Table with Full Details -->
<div class="card mb-4 shadow-sm">
    <div class="card-header bg-primary text-white">
        <i class="bi bi-table me-2"></i>All Orders 📄
    </div>
    <div class="card-body table-responsive">
        <table class="table table-bordered table-striped align-middle text-center" style="table-layout: fixed; word-wrap: break-word;">
            <thead class="table-light">
                <tr>
                    <th style="width: 60px;">ID</th>
                    <th style="width: 120px;"> Username</th>
                    <th style="width: 140px;">Product</th>
                    <th style="width: 90px;"> Price</th>
                    <th style="width: 70px;">Qty</th>
                    <th style="width: 160px;"> Date</th>
                    <th style="width: 150px;"> Full Name</th>
                    <th style="width: 250px;"> Address</th>
                    <th style="width: 140px;"> Phone</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM orders ORDER BY order_date DESC");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getString("product_name") %></td>
                    <td>₹<%= rs.getDouble("price") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getTimestamp("order_date") %></td>
                    <td><%= rs.getString("full_name") != null ? rs.getString("full_name") : "<em class='text-muted'>N/A</em>" %></td>
                    <td><%= rs.getString("address") != null ? rs.getString("address") : "<em class='text-muted'>N/A</em>" %></td>
                    <td><%= rs.getString("phone") != null ? rs.getString("phone") : "<em class='text-muted'>N/A</em>" %></td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='9' class='text-danger'>⚠️ Error loading orders: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
   

    <!-- Products Quantity Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white">
            <i class="bi bi-boxes me-2"></i>Products & Stock 📦
        </div>
        <div class="card-body table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-success">
                    <tr>
                        <th>Product Name</th>
                        <th>Available Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT name, quantity FROM products");
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                    </tr>
                    <%
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("<tr><td colspan='2' class='text-danger'>Error loading products: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
