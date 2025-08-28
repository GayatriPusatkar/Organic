<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/aditya";
    String dbUser = "root";
    String dbPassword = "root";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "INSERT INTO login_details (name, password) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, password);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
%>
            <script>alert("Registration successful!"); window.location.href='NewFile.html';</script>
<%
        } else {
%>
            <script>alert("Failed to register user."); window.location.href='NewFile.html';</script>
<%
        }

        pstmt.close();
        conn.close();

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
