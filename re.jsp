<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");

    String fullName = request.getParameter("full_name");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    
    
    boolean success = false;

    
    if (fullName != null && email != null && username != null && password != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                     "jdbc:mysql://localhost:3306/organic_shop", "root", "root");
                 PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (full_name, email, username, password) VALUES (?, ?, ?, ?)")) {

                stmt.setString(1, fullName);
                stmt.setString(2, email);
                stmt.setString(3, username);
                stmt.setString(4, password);

                success = stmt.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (success) {
%>
        <script>
            alert("Registration Successful! You may login now.");
            window.location.href = "login.html";
        </script>
<%
    } else {
%>
        <script>
            alert("Registration Failed! Try again.");
            window.location.href = "register.html";
        </script>
<%
    }
%>
