<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");
        String sql = "INSERT INTO feedbacks (name, email, message) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, message);

        int rows = stmt.executeUpdate();
        if (rows > 0) {
%>
            <script>
                alert("🙏 Thanks for your feedback! 😊");
                window.location.href = "contact.html";
            </script>
<%
        } else {
%>
            <script>
                alert("⚠️ Something went wrong. Please try again!");
                window.location.href = "contact.html";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("❌ Error: <%= e.getMessage() %>");
            window.location.href = "contact.html";
        </script>
<%
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
