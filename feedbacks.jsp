<%@ page import="java.sql.*, java.util.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = "jdbc:mysql://localhost:3306/organic_shop";
    String user = "root";
    String password = "root";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String deleteId = request.getParameter("deleteId");
        if (deleteId != null) {
            stmt = conn.prepareStatement("DELETE FROM feedbacks WHERE id = ?");
            stmt.setInt(1, Integer.parseInt(deleteId));
            stmt.executeUpdate();
            stmt.close();
        }

        stmt = conn.prepareStatement("SELECT * FROM feedbacks ORDER BY submitted_at DESC");
        rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>📬 Feedbacks</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    body, html {
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
    }
    @media (max-width: 768px) {
        .sidebar {
            display: none;
        }
        .content {
            margin-left: 0;
            padding: 10px;
        }
    }
    .table-container {
        background: #f1f8e9;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .table th {
        background-color: #aed581;
        color: #1b5e20;
        font-size: 1.1rem;
    }
    .table td {
        vertical-align: middle;
        background-color: #ffffff;
    }
    .table td a.btn {
        transition: transform 0.2s ease;
    }
    .table td a.btn:hover {
        transform: scale(1.05);
    }
  </style>
</head>
<body>

<nav class="navbar navbar-dark bg-success d-md-none">
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
    <a href="feedbacks.jsp" class="d-block py-2 text-white"><i class="fas fa-comments"></i> User Feedback</a>
    <a href="index.html" class="d-block py-2 text-white logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
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
  <a href="index.html" class="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<div class="content">
  <h3 class="mb-4">📬 User Feedbacks</h3>
  <div class="table-container">
    <div class="table-responsive">
      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Message</th>
            <th>Submitted At</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String message = rs.getString("message");
                String time = rs.getTimestamp("submitted_at").toString();
        %>
          <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= email %></td>
            <td><%= message.length() > 30 ? message.substring(0, 30) + "..." : message %></td>
            <td><%= time %></td>
            <td>
              <button class="btn btn-sm btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#viewModal<%= id %>">
                <i class="fas fa-eye"></i> View
              </button>
              <a href="feedbacks.jsp?deleteId=<%= id %>" class="btn btn-sm btn-outline-danger"
                 onclick="return confirm('Are you sure you want to delete this feedback?');">
                <i class="fas fa-trash"></i> Delete
              </a>
            </td>
          </tr>

          <!-- View Modal -->
          <div class="modal fade" id="viewModal<%= id %>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-header bg-success text-white">
                  <h5 class="modal-title">Feedback from <%= name %></h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                  <p><strong>Email:</strong> <%= email %></p>
                  <p><strong>Message:</strong></p>
                  <p><%= message %></p>
                  <p class="text-muted"><strong>Submitted At:</strong> <%= time %></p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
        <%
            }
        %>
        </tbody>
      </table>
    </div>
  </div>
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
