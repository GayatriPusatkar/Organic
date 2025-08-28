<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/organic_shop";
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String category = request.getParameter("category");
    String ajax = request.getParameter("ajax");

    // DB Query
    String sql = "SELECT * FROM products";
    if (category != null && !category.equals("all")) {
        sql += " WHERE category=?";
    }

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        if (category != null && !category.equals("all")) {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, category);
        } else {
            stmt = conn.prepareStatement(sql);
        }

        rs = stmt.executeQuery();

        if ("true".equals(ajax)) {
            // Only return the product list HTML
            while (rs.next()) {
%>
                <div class="product">
                    <h3><%= rs.getString("name") %></h3>
                    <p>Price: $<%= rs.getDouble("price") %></p>
                    <p>Category: <%= rs.getString("category") %></p>
                </div>
<%
            }
            return; // Stop here if it's an AJAX request
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Shop Page</title>
    <style>
        .filter-section, .product-section {
            padding: 20px;
        }
        .product { border: 1px solid #ccc; padding: 10px; margin: 10px; }
    </style>
</head>
<body>

<h2>Welcome to Our Shop</h2>

<div class="filter-section">
    <label for="category">Filter by Category:</label>
    <select id="category">
        <option value="all">All</option>
        <option value="Fruits">Fruits</option>
        <option value="Vegetables">Vegetables</option>
        <option value="Dairy">Dairy</option>
    </select>
</div>

<div id="productList" class="product-section">
<%
        while (rs.next()) {
%>
    <div class="product">
        <h3><%= rs.getString("name") %></h3>
        <p>Price: $<%= rs.getDouble("price") %></p>
        <p>Category: <%= rs.getString("category") %></p>
    </div>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
</div>

<script>
    document.getElementById("category").addEventListener("change", function () {
        var category = this.value;
        var formData = new FormData();
        formData.append("category", category);

        fetch("shop.jsp?ajax=true", {
            method: "POST",
            body: formData
        })
        .then(res => res.text())
        .then(data => {
            document.getElementById("productList").innerHTML = data;
        });
    });
</script>

</body>
</html>
