<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    int productId = Integer.parseInt(request.getParameter("productId"));
    int orderedQty = Integer.parseInt(request.getParameter("productQty"));
    String username = request.getParameter("username");
    String fullName = request.getParameter("fullName");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/organic_shop", "root", "root");

        PreparedStatement ps = con.prepareStatement("SELECT name, price, quantity FROM products WHERE product_id = ?");
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int currentQty = rs.getInt("quantity");
            String productName = rs.getString("name");
            double price = rs.getDouble("price");

            if (orderedQty <= currentQty) {
                PreparedStatement updatePs = con.prepareStatement("UPDATE products SET quantity = quantity - ? WHERE product_id = ?");
                updatePs.setInt(1, orderedQty);
                updatePs.setInt(2, productId);
                int rows = updatePs.executeUpdate();

                if (rows > 0) {
                    PreparedStatement insertOrder = con.prepareStatement(
                        "INSERT INTO orders (username, product_name, price, quantity, full_name, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?)");
                    insertOrder.setString(1, username);
                    insertOrder.setString(2, productName);
                    insertOrder.setDouble(3, price);
                    insertOrder.setInt(4, orderedQty);
                    insertOrder.setString(5, fullName);
                    insertOrder.setString(6, address);
                    insertOrder.setString(7, phone);
                    insertOrder.executeUpdate();
                    insertOrder.close();

                    out.println("<script>alert('🎉 Thank you! Your order has been placed successfully. 🛵\\n\\n🚚 Product will be delivered to your doorstep in half an hour ⏳\\n\\n💵 Payment: Cash on Delivery'); window.location='shop.jsp';</script>");
                } else {
                    out.println("<script>alert('❌ Failed to update product quantity.');</script>");
                }

                updatePs.close();
            } else {
                out.println("<script>alert('❌ Not enough stock available. Only " + currentQty + " quantity left.'); window.location='shop.jsp';</script>");
            }
        } else {
            out.println("<script>alert('❌ Product not found.');</script>");
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<script>alert('⚠️ Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Place Order</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
  
  <style>
    .order-box {
      background-color: #ffffff;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }
    .product-img {
      max-width: 100%;
      height: auto;
      border-radius: 10px;
    }
    .shadow-input {
      box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    }
  </style>
</head>
<body class="bg-light">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-8 order-box">
        <div class="text-center mb-4">
          <i class="fa fa-user fa-2x"></i>
          <div id="username" style="margin-top: 5px; font-weight: bold;"></div>
        </div>

        <h2 class="text-center mb-4">🛒 Order Summary</h2>

        <div class="row align-items-center mb-4">
          <div class="col-md-5">
            <img id="productImage" src="" alt="Product Image" class="product-img" />
          </div>
          <div class="col-md-7">
            <ul class="list-group">
              <li class="list-group-item"><strong>Product:</strong> <span id="pname"></span></li>
              <li class="list-group-item"><strong>Price per Kg:</strong> ₹<span id="pprice"></span></li>
              <li class="list-group-item">
                <strong>Quantity (Kg):</strong>
                <input type="number" id="pqty" class="form-control d-inline-block w-50 ms-2 shadow-input" name="quantity" min="1" value="1" required />
              </li>
              <li class="list-group-item"><strong>Total:</strong> ₹<span id="ptotal"></span></li>
              <li class="list-group-item text-success"><strong>Payment Mode:</strong> Cash on Delivery 💵</li>
            </ul>
          </div>
        </div>

        <h4 class="mb-3">📦 Delivery Information</h4>
        <form id="orderForm" method="post">
          <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="fullName" class="form-control shadow-input" required />
          </div>
          <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control shadow-input" rows="3" required></textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">Phone Number</label>
            <input type="tel" name="phone" class="form-control shadow-input" required />
          </div>
          <input type="hidden" name="productId" id="productIdInput" />
          <input type="hidden" name="productQty" id="productQtyInput" />
          <input type="hidden" name="username" id="usernameInput" />
          <button type="submit" class="btn btn-success w-100">✅ Place Order</button>
        </form>
      </div>
    </div>
  </div>

  <script>
    const sessionUsername = sessionStorage.getItem("username") || "User";
    document.getElementById("username").textContent = sessionUsername;

    const product = JSON.parse(localStorage.getItem("order"));
    console.log("Product object:", product); // For debugging

    const price = product.price;
    const qtyInput = document.getElementById("pqty");
    const totalSpan = document.getElementById("ptotal");

    document.getElementById("pname").textContent = product.name;
    document.getElementById("pprice").textContent = price;
    document.getElementById("productImage").src = product.image || "https://via.placeholder.com/300x200?text=Product";

    function updateTotal() {
      const qty = parseFloat(qtyInput.value);
      const total = qty * price;
      totalSpan.textContent = total.toFixed(2);
    }

    updateTotal();
    qtyInput.addEventListener("input", updateTotal);

    document.getElementById("orderForm").addEventListener("submit", function () {
      document.getElementById("productIdInput").value = product.product_id || product.id;
      document.getElementById("productQtyInput").value = qtyInput.value;
      document.getElementById("usernameInput").value = sessionUsername;
      localStorage.removeItem("order");
    });
  </script>
</body>
</html>