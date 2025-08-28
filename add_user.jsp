<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    String messageType = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String full_name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (full_name == null || email == null || username == null || password == null ||
            full_name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {
            message = "⚠️ Please fill in all fields!";
            messageType = "error";
        } else {
            Connection conn = null;
            PreparedStatement pst = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");

                String sql = "INSERT INTO users (full_name, email, username, password) VALUES (?, ?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setString(1, full_name);
                pst.setString(2, email);
                pst.setString(3, username);
                pst.setString(4, password);
                int result = pst.executeUpdate();

                if (result > 0) {
                    message = "✅ User added successfully!";
                    messageType = "success";
                } else {
                    message = "❌ Failed to add user.";
                    messageType = "error";
                }

            } catch (Exception e) {
                message = "🚫 Error: " + e.getMessage();
                messageType = "error";
            } finally {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add User</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
        }

        .background {
            background: url('assets/Images/Home/banner-ad-1.jpg') no-repeat center center/cover;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-box {
            background-color: rgba(255, 255, 255, 0.25);
            padding: 40px 30px;
            border-radius: 20px;
            backdrop-filter: blur(12px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        input, button {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            background-color: rgba(255, 255, 255, 0.9);
        }

        button {
            background-color: #28a745;
            width:50%;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }

        .cancel-btn {
            background-color: #6c757d;
        }

        .cancel-btn:hover {
            background-color: #5a6268;
        }

        @media (max-width: 420px) {
            .form-box {
                padding: 25px 20px;
            }

            h2 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
<div class="background">
    <div class="form-box">
        <h2>➕ Add New User</h2>
        <form method="post">
            <input type="text" name="full_name" placeholder="👤 Full Name" required />
            <input type="email" name="email" placeholder="📧 Email" required />
            <input type="text" name="username" placeholder="🧑 Username" required />
            <input type="password" name="password" placeholder="🔒 Password" required />
            <button type="submit">Add User</button>
            <button type="button" class="cancel-btn" onclick="window.location.href='user_management.jsp'">Cancel</button>
        </form>
    </div>
</div>

<% if (!message.isEmpty()) { %>
    <script>
        alert("<%= message %>");
        <% if (messageType.equals("success")) { %>
            window.location.href = "user_management.jsp";
        <% } %>
    </script>
<% } %>
</body>
</html>
