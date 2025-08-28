<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    String messageType = "";
    String userId = request.getParameter("id");

    String full_name = "";
    String email = "";
    String username = "";
    String password = "";

    if (userId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, userId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                full_name = rs.getString("full_name");
                email = rs.getString("email");
                username = rs.getString("username");
                password = rs.getString("password");
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            message = "🚫 Error: " + e.getMessage();
            messageType = "error";
        }
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        full_name = request.getParameter("full_name");
        email = request.getParameter("email");
        username = request.getParameter("username");
        password = request.getParameter("password");

        if (full_name == null || email == null || username == null || password == null ||
            full_name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {
            message = "⚠️ Please fill in all fields!";
            messageType = "error";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                String sql = "UPDATE users SET full_name=?, email=?, username=?, password=? WHERE id=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, full_name);
                pst.setString(2, email);
                pst.setString(3, username);
                pst.setString(4, password);
                pst.setString(5, userId);

                int result = pst.executeUpdate();

                if (result > 0) {
                	message = "✅ User updated successfully! 📧 Notification sent to user's email.";

                    messageType = "success";
                } else {
                    message = "❌ Failed to update user.";
                    messageType = "error";
                }

                pst.close();
                conn.close();
            } catch (Exception e) {
                message = "🚫 Error: " + e.getMessage();
                messageType = "error";
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
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
            background-color: #007bff;
            width:50%;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #0069d9;
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
        <h2>✏️ Edit User</h2>
        <form method="post">
            <input type="text" name="full_name" placeholder="👤 Full Name" value="<%= full_name %>" required />
            <input type="email" name="email" placeholder="📧 Email" value="<%= email %>" required />
            <input type="text" name="username" placeholder="🧑 Username" value="<%= username %>" required />
            <input type="password" name="password" placeholder="🔒 Password" value="<%= password %>" required />
            <button type="submit">Update</button>
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
