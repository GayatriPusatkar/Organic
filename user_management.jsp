<%@ page import="java.sql.*, java.util.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String url = "jdbc:mysql://localhost:3306/organic_shop";
    String user = "root";
    String password = "root";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();

        if (request.getParameter("deleteId") != null) {
            int deleteId = Integer.parseInt(request.getParameter("deleteId"));
            stmt.executeUpdate("DELETE FROM users WHERE id=" + deleteId);
        }

        rs = stmt.executeQuery("SELECT * FROM users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            transition: width 0.3s ease;
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
            transition: background 0.3s;
        }
        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            min-height: 100vh;
        }
        .sidebar .logout {
            margin-top: auto;
            color: white;
        }
        .header {
            background-color: #1b5e20;
            color: white;
            padding: 10px;
            border-bottom: 4px solid #81c784;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            padding-left: 270px;
        }
        /* Full-width offcanvas navbar on small screens */
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            .content {
                margin-left: 0;
            }
            
            
            @media (max-width: 320px) {
            .off{
            width:160% !important;}
            }
        }
    </style>
</head>
<body>

<!-- Offcanvas Navbar -->
<nav class="navbar navbar-dark off bg-success d-md-none">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <span class="navbar-brand mb-0 h1">Admin Panel</span>
  </div>
</nav>

<div class="offcanvas offcanvas-start d-md-none bg-success text-white" tabindex="-1" id="offcanvasNavbar">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title">Admin Panel</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <a href="admindashboard.html" class="d-block py-2 text-white"><i class="fas fa-home"></i> Home</a>
    <a href="product_management.jsp" class="d-block py-2 text-white"><i class="fas fa-box"></i> Product Management</a>
    <a href="user_management.jsp" class="d-block py-2 text-white"><i class="fas fa-users"></i> User Management</a>
    <a href="report_analytics.jsp" class="d-block py-2 text-white"><i class="fas fa-chart-line"></i> Orders & Insights</a>
    <a href="admin_settings.jsp" class="d-block py-2 text-white"><i class="fas fa-cog"></i> Admin Settings</a>
    <a href="index.html" class="d-block py-2 text-white logout" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </div>
</div>

<!-- Sidebar for md and up -->
<div class="sidebar d-none d-md-block">
  <h4>Admin Panel</h4>
  <a href="admindashboard.html"><i class="fas fa-home"></i> Home</a>
  <a href="product_management.jsp"><i class="fas fa-box"></i> Product Management</a>
  <a href="user_management.jsp"><i class="fas fa-users"></i> User Management</a>
  <a href="report_analytics.jsp"><i class="fas fa-chart-line"></i> Orders & Insights</a>
   <a href="feedbacks.jsp"><i class="fas fa-comments"></i> User Feedback</a>
  
  <a href="admin_settings.jsp"><i class="fas fa-cog"></i> Admin Settings</a>
  <a href="index.html" class="logout" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Content -->
<div class="content">
    <h3 class="mb-4">User List</h3>
    <a href="add_user.jsp" class="btn btn-success mb-3"><i class="fas fa-user-plus"></i> Add New User</a>
    <table class="table table-bordered table-striped table-hover">
        <thead class="table-success">
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Username</th>
            <th>Password</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("full_name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("password") %></td>
            <td>
                <a href="edit_user.jsp?id=<%= rs.getInt("id") %>" class="btn btn-primary btn-sm"><i class="fas fa-edit"></i> Edit</a>
                <a href="user_management.jsp?deleteId=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
