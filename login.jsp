<%@ page import="java.sql.*" %>  
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        boolean isUser = false;
        String dbUrl = "jdbc:mysql://localhost:3306/organic_shop";
        String dbUser = "root";
        String dbPass = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            String sqlUser = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmtUser = conn.prepareStatement(sqlUser);
            stmtUser.setString(1, username);
            stmtUser.setString(2, password);
            ResultSet rsUser = stmtUser.executeQuery();

            if (rsUser.next()) {
                isUser = true;
                session.setAttribute("username", username); // ✅ Store in session
            }

            rsUser.close();
            stmtUser.close();
            conn.close();
        } catch (Exception e) {
%>
<script>
    alert("🚫 Database Error: <%= e.getMessage() %>");
    window.location.href = "login.html";
</script>
<%
        }

        if (isUser) {
%>
<script>
    sessionStorage.setItem("username", "<%= username %>"); // ✅ Store for frontend use
    alert("🎉 Welcome <%= username %>!");
    window.location.href = "home.html"; // ✅ Redirect to home.html
</script>
<%
        } else {
%>
<script>
    alert("❌ Invalid user credentials");
    window.location.href = "login.html";
</script>
<%
        }
    } else {
%>
<script>
    alert("⚠️ Please enter both username and password");
    window.location.href = "login.html";
</script>
<%
    }
%>
