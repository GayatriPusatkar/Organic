<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Settings</title>
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
    .form-container {
      background-color: #ffffff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }
    .form-container h2 {
      text-align: center;
      font-size: 2rem;
      margin-bottom: 20px;
    }
    .form-box label {
      font-weight: bold;
    }
    .form-box input[type="text"],
    .form-box input[type="password"] {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 5px;
      border: 1px solid #ccc;
    }
    .form-box button {
      width: 100%;
      padding: 12px;
      background-color: #007bff;
      border: none;
      border-radius: 5px;
      color: white;
      font-size: 1.1rem;
      cursor: pointer;
    }
    .form-box button:hover {
      background-color: #0056b3;
    }
    table {
      width: 100%;
      margin-top: 20px;
    }
    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #007bff;
      color: white;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    @media (max-width: 768px) {
      .sidebar {
        display: none;
      }
      .content {
        margin-left: 0;
      }
    }
  </style>
</head>
<body>
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

<div class="content">
  <div class="container">
    <div class="form-container">
      <h2>Admin Settings</h2>
      <form method="post" action="admin_settings.jsp" class="form-box">
        <label for="username">New Admin Username</label>
        <input type="text" id="username" name="username" required>
        <label for="password">New Admin Password</label>
        <input type="password" id="password" name="password" required>
        <button type="submit">Add Admin</button>
      </form>
    </div>

    <div class="table-responsive">
      <h3 class="mb-3">Current Admins</h3>
      <table class="table table-bordered align-middle">
        <thead>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Password</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <%
            try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
              Statement stmt = con.createStatement();
              ResultSet rs = stmt.executeQuery("SELECT * FROM admin");
              while (rs.next()) {
                int id = rs.getInt("id");
          %>
          <tr>
            <form method="post" action="admin_settings.jsp">
              <td><%= id %></td>
              <td><input type="text" name="updateUsername" value="<%= rs.getString("username") %>" required class="form-control"></td>
              <td><input type="password" name="updatePassword" value="<%= rs.getString("password") %>" required class="form-control"></td>
              <td>
                <input type="hidden" name="adminId" value="<%= id %>"/>
                <div class="d-flex gap-2">
                  <button type="submit" name="action" value="update" class="btn btn-warning btn-sm">Update</button>
                  <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure to delete this admin?');">Delete</button>
                </div>
              </td>
            </form>
          </tr>
          <%
              }
              con.close();
            } catch (Exception e) {
              e.printStackTrace();
              out.println("<tr><td colspan='4'>Error loading admins</td></tr>");
            }
          %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%
  String newUsername = request.getParameter("username");
  String newPassword = request.getParameter("password");
  String action = request.getParameter("action");
  String updateUsername = request.getParameter("updateUsername");
  String updatePassword = request.getParameter("updatePassword");
  String adminId = request.getParameter("adminId");

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");

    if (newUsername != null && newPassword != null) {
      PreparedStatement ps = con.prepareStatement("INSERT INTO admin (username, password) VALUES (?, ?)");
      ps.setString(1, newUsername);
      ps.setString(2, newPassword);
      ps.executeUpdate();
      out.println("<script>alert('New admin added successfully!');location='admin_settings.jsp';</script>");
    } else if (action != null && adminId != null) {
      if (action.equals("update")) {
        PreparedStatement ps = con.prepareStatement("UPDATE admin SET username=?, password=? WHERE id=?");
        ps.setString(1, updateUsername);
        ps.setString(2, updatePassword);
        ps.setInt(3, Integer.parseInt(adminId));
        ps.executeUpdate();
        out.println("<script>alert('Admin updated successfully!');location='admin_settings.jsp';</script>");
      } else if (action.equals("delete")) {
        PreparedStatement ps = con.prepareStatement("DELETE FROM admin WHERE id=?");
        ps.setInt(1, Integer.parseInt(adminId));
        ps.executeUpdate();
        out.println("<script>alert('Admin deleted successfully!');location='admin_settings.jsp';</script>");
      }
    }
    con.close();
  } catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('Operation failed.');</script>");
  }
%>

<script>
  function logout() {
    window.location.href = 'index.html';
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
