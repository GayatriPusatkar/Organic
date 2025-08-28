<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Processing</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String fullName = request.getParameter("fullname");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");

    String[] productIds = request.getParameterValues("productIds[]");
    String[] qtys = request.getParameterValues("qtys[]");

    String dbURL = "jdbc:mysql://localhost:3306/organic_shop";
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        for (int i = 0; i < productIds.length; i++) {
            int pid = Integer.parseInt(productIds[i]);
            int orderedQty = Integer.parseInt(qtys[i]);

            // Get product details
            PreparedStatement ps = conn.prepareStatement("SELECT name, price, quantity FROM products WHERE product_id = ?");
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String pname = rs.getString("name");
                double price = rs.getDouble("price");
                int availableQty = rs.getInt("quantity");

                if (orderedQty <= availableQty) {
                    // Update inventory
                    pst = conn.prepareStatement("UPDATE products SET quantity = quantity - ? WHERE product_id = ?");
                    pst.setInt(1, orderedQty);
                    pst.setInt(2, pid);
                    pst.executeUpdate();
                    pst.close();

                    // Insert order
                    pst = conn.prepareStatement(
                        "INSERT INTO orders (username, product_name, price, quantity, full_name, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?)"
                    );
                    pst.setString(1, username);
                    pst.setString(2, pname);
                    pst.setDouble(3, price);
                    pst.setInt(4, orderedQty);
                    pst.setString(5, fullName);
                    pst.setString(6, address);
                    pst.setString(7, phone);
                    pst.executeUpdate();
                    pst.close();
                } else {
                    out.println("<script>alert('❌ Not enough stock for " + pname + ". Only " + availableQty + " left.');</script>");
                }
            }
            rs.close();
            ps.close();
        }
%>
<script>
    alert("✅ Order placed successfully!");
    sessionStorage.removeItem("cart");
    window.location.href = "shop.jsp";
</script>
<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>❌ Error: " + e.getMessage() + "</p>");
    } finally {
        if (pst != null) try { pst.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
