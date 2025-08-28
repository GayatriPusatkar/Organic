<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Product Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body, html {
      height: 100%;
      margin: 0;
      font-family: Arial, sans-serif;
    }
    .sidebar {
      height: 100vh;
      width: 250px;
      position: fixed;
      top: 0;
      left: 0;
      background: #2e7d32;
      padding-top: 20px;
      color: white;
      transition: 0.3s;
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
    .header {
      background-color: #1b5e20;
      color: white;
      padding: 10px;
      border-bottom: 4px solid #81c784;
      position: sticky;
      top: 0;
      z-index: 1000;
    }
    @media (max-width: 768px) {
      .sidebar {
        position: relative;
        width: 100%;
        height: auto;
      }
      .content {
        margin-left: 0 !important;
      }
    }
    .table td, .table th {
      vertical-align: middle;
    }
  </style>
</head>
<body>

<!-- Sidebar for desktop -->
<div class="sidebar d-none d-md-block">
  <h4>Admin Panel</h4>
  <a href="admindashboard.html"><i class="fas fa-home"></i> Home</a>
  <a href="product_management.jsp"><i class="fas fa-box"></i> Product Management</a>
  <a href="user_management.jsp"><i class="fas fa-users"></i> User Management</a>
  <a href="report_analytics.jsp"><i class="fas fa-chart-line"></i> Orders & Insights</a>
  <a href="admin_settings.jsp"><i class="fas fa-cog"></i> Admin Settings</a>
  <a href="feedbacks.jsp"><i class="fas fa-comments"></i> User Feedback</a>
  <a href="index.html" class="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Responsive menu for mobile -->
<!-- Responsive menu for mobile -->
<nav class="navbar navbar-expand-md navbar-dark bg-success d-md-none">
  <div class="container-fluid">
    <button class="navbar-toggler me-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="#">Admin Panel</a>
    <div class="collapse navbar-collapse" id="navbarMenu">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="admindashboard.html">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="product_management.jsp">Product Management</a></li>
        <li class="nav-item"><a class="nav-link" href="user_management.jsp">User Management</a></li>
        <li class="nav-item"><a class="nav-link" href="report_analytics.jsp">Orders & Insights</a></li>
        <li class="nav-item"><a class="nav-link" href="admin_settings.jsp">Admin Settings</a></li>
        <li class="nav-item"><a class="nav-link" href="feedbacks.jsp">User Feedback</a></li>
        <li class="nav-item"><a class="nav-link" href="index.html">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>


<div class="content" style="margin-left: 250px;">
  <div class="container-fluid mt-3">
<%
    String url = "jdbc:mysql://localhost:3306/organic_shop";
    String user = "root", pass = "root";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String action = request.getParameter("action");
    String catId = request.getParameter("category_id");
    String catName = request.getParameter("category_name");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        stmt = conn.createStatement();

        if ("addCategory".equals(action) && catName != null && !catName.isEmpty()) {
            stmt.executeUpdate("INSERT INTO categories (category_name) VALUES ('" + catName + "')");
        } else if ("deleteCategory".equals(action) && catId != null) {
            stmt.executeUpdate("DELETE FROM categories WHERE category_id = " + catId);
        }

        if ("addProduct".equals(action)) {
            String pname = request.getParameter("pname");
            String price = request.getParameter("price");
            String pcid = request.getParameter("pcategory");
            String features = request.getParameter("features");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String link = request.getParameter("link");
            String quantity = request.getParameter("quantity");

            if (pname != null && price != null && pcid != null) {
                stmt.executeUpdate("INSERT INTO products (name, price, category_id, features, image, description, link, quantity) VALUES (" +
                        "'" + pname + "', '" + price + "', " + pcid + ", '" + features + "', '" + image + "', '" + description + "', '" + link + "', " + quantity + ")");
            }
        } else if ("deleteProduct".equals(action) && request.getParameter("product_id") != null) {
            stmt.executeUpdate("DELETE FROM products WHERE product_id = " + request.getParameter("product_id"));
        }
%>

    <h4 class="mt-3">Manage Categories</h4>
    <form method="post" class="row g-2">
      <div class="col-sm-6 col-md-4 col-lg-3">
        <input type="text" name="category_name" class="form-control" placeholder="New Category Name" required />
        <input type="hidden" name="action" value="addCategory"/>
      </div>
      <div class="col-sm-6 col-md-2">
        <button class="btn btn-success w-100">Add Category</button>
      </div>
    </form>

    <table class="table table-bordered table-striped mt-3">
      <tr><th>ID</th><th>Name</th><th>Action</th></tr>
      <%
        rs = stmt.executeQuery("SELECT * FROM categories");
        while (rs.next()) {
      %>
      <tr>
        <td><%= rs.getInt("category_id") %></td>
        <td><%= rs.getString("category_name") %></td>
        <td>
          <a href="product_management.jsp?action=deleteCategory&category_id=<%= rs.getInt("category_id") %>" class="btn btn-danger btn-sm">Delete</a>
        </td>
      </tr>
      <% } %>
    </table>

    <h4 class="mt-5">Manage Products</h4>
    <form method="post" class="row g-2">
      <input type="hidden" name="action" value="addProduct" />
      <div class="col-md-3"><input class="form-control" type="text" name="pname" placeholder="Product Name" required></div>
      <div class="col-md-2"><input class="form-control" type="text" name="price" placeholder="Price" required></div>
      <div class="col-md-2">
        <select name="pcategory" class="form-control" required>
          <option value="">Select Category</option>
          <%
            rs = stmt.executeQuery("SELECT * FROM categories");
            while (rs.next()) {
          %>
          <option value="<%= rs.getInt("category_id") %>"><%= rs.getString("category_name") %></option>
          <% } %>
        </select>
      </div>
      <div class="col-md-2"><input class="form-control" type="text" name="features" placeholder="Features"></div>
      <div class="col-md-3"><input class="form-control" type="text" name="image" placeholder="Image Path"></div>
      <div class="col-md-6"><input class="form-control" type="text" name="description" placeholder="Description"></div>
      <div class="col-md-3"><input class="form-control" type="text" name="link" placeholder="Product Link"></div>
      <div class="col-md-2"><input class="form-control" type="number" name="quantity" placeholder="Qty"></div>
      <div class="col-md-1"><button class="btn btn-success w-100">Add</button></div>
    </form>

    <table class="table table-bordered table-striped mt-3">
      <tr><th>ID</th><th>Name</th><th>Price</th><th>Category</th><th>Qty</th><th>Action</th></tr>
      <%
        rs = stmt.executeQuery("SELECT p.*, c.category_name FROM products p JOIN categories c ON p.category_id = c.category_id");
        while (rs.next()) {
      %>
      <tr>
        <td><%= rs.getInt("product_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getString("category_name") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td>
          <a href="product_management.jsp?action=deleteProduct&product_id=<%= rs.getInt("product_id") %>" class="btn btn-danger btn-sm">Delete</a>
        </td>
      </tr>
      <% } %>
    </table>

<%
    } catch(Exception e) {
        out.print("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
