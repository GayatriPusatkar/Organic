<%@ page import="java.sql.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        boolean isAdmin = false;
        String dbUrl = "jdbc:mysql://localhost:3306/organic_shop";
        String dbUser = "root";
        String dbPass = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            String sqlAdmin = "SELECT * FROM admin WHERE username=? AND password=?";
            PreparedStatement stmtAdmin = conn.prepareStatement(sqlAdmin);
            stmtAdmin.setString(1, username);
            stmtAdmin.setString(2, password);
            ResultSet rsAdmin = stmtAdmin.executeQuery();

            if (rsAdmin.next()) {
                isAdmin = true;
            }

            rsAdmin.close();
            stmtAdmin.close();
            conn.close();
        } catch (Exception e) {
            out.println("<script>alert('🚫 Database Error: " + e.getMessage() + "'); window.location='login.html';</script>");
        }

        if (isAdmin) {
%>
<script>
    sessionStorage.setItem("username", "<%= username %>");
    alert("👑 Welcome Admin <%= username %>!");
    window.location.href = "admindashboard.html";
</script>
<%
        } else {
%>
<script>
    alert("❌ Invalid admin credentials");
    window.location.href = "admin-login.html";
</script>
<%
        }
    } else {
%>
<script>
    alert("⚠️ Please enter both username and password");
    window.location.href = "admin-login.html";
</script>
<%
    }
%>
