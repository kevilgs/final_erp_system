<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product_Pojo" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Admin Dashboard</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
      crossorigin="anonymous"
    />
    <style>
      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .sidebar {
        height: 100vh;
        background-color: #2c3e50;
        color: white;
        padding-top: 20px;
      }
      .sidebar .nav-link {
        color: #ecf0f1;
        transition: all 0.3s ease;
        border-radius: 5px;
        margin-bottom: 5px;
      }
      .sidebar .nav-link:hover,
      .sidebar .nav-link.active {
        background-color: #34495e;
        color: #fff;
      }
      .content-header {
        background-color: #ecf0f1;
        padding: 15px 20px;
        border-bottom: 1px solid #bdc3c7;
      }
      .main-content {
        padding: 20px;
        background-color: #f9f9f9;
        min-height: calc(100vh - 61px);
      }
      .btn-logout {
        background-color: #e74c3c;
        border-color: #c0392b;
      }
      .btn-logout:hover {
        background-color: #c0392b;
      }
      .edit-form {
        display: none;
        margin-top: 10px;
      }
      #addProductForm {
        display: none;
      }
      .sticky-top {
        position: sticky;
        top: 0;
        z-index: 1;
        background-color: #212529;
      }
      .table-responsive::-webkit-scrollbar {
        width: 8px;
        height: 8px;
      }
      .table-responsive::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 4px;
      }
      .table-responsive::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 4px;
      }
      .table-responsive::-webkit-scrollbar-thumb:hover {
        background: #555;
      }
      .product-list-panel {
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 0.25rem;
      }
      .table th {
        white-space: nowrap;
      }
    </style>
    <script>
      function toggleEditForm(productId) {
        var form = document.getElementById("editForm-" + productId);
        form.style.display = form.style.display === "none" ? "block" : "none";
      }

      function toggleAddProductForm() {
        var addForm = document.getElementById("addProductForm");
        addForm.style.display = addForm.style.display === "none" ? "block" : "none";
      }
    </script>
  </head>
  <body>
    <div class="container-fluid">
      <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 sidebar d-flex flex-column p-3">
          <h4 class="text-center mb-4">Admin Panel</h4>
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link" href="Admin_Dashboard">
                <i class="bi bi-speedometer2 me-2"></i>Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="UserManagement.jsp">
                <i class="bi bi-people me-2"></i>User Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="product_management.jsp">
                <i class="bi bi-box-seam me-2"></i>Product Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="algorithm_monitoring.jsp">
                <i class="bi bi-people me-2"></i>Algorithm Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="feedback.jsp">
                <i class="bi bi-chat-dots me-2"></i>Feedback Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="Report_Generation">
                <i class="bi bi-file-earmark-text me-2"></i>Report Management
              </a>
            </li>
          </ul>
        </nav>

        <!-- Main Content -->
        <div class="col-md-2 col-lg-10 p-0">
          <!-- Header -->
          <div class="content-header d-flex justify-content-between align-items-center">
            <h6 class="mb-0">Welcome, Admin</h6>
          </div>

          <!-- Dynamic Content -->
          <div class="main-content" id="main-content">
            <!-- Product Management Section -->
            <div class="container mt-1">
              <div class="card shadow">
                <div class="card-body">
                  <h3 class="card-title">Product Management</h3>
                  <p class="card-text">Manage products, add new products, and edit product details.</p>

                  <!-- Add New Product Button -->
                  <button onclick="toggleAddProductForm()" class="btn btn-primary mb-2">Add New Product</button>

                  <!-- Form to submit action to "list" -->
                  <form action="ProductController" method="GET" class="mb-3">
                    <input type="hidden" name="action" value="list">
                    <button type="submit" class="btn btn-success">List All Products</button>
                  </form>

                  <!-- Add New Product Form -->
                  <div id="addProductForm" class="mb-4">
                    <h2 class="mt-4">Add New Product</h2>
                    <form action="ProductController" method="POST">
                      <input type="hidden" name="action" value="add">
                      <div class="mb-3">
                        <label for="name" class="form-label">Product Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                      </div>
                      <div class="mb-3">
                        <label for="category" class="form-label">Category</label>
                        <input type="text" class="form-control" id="category" name="category" required>
                      </div>
                      <div class="mb-3">
                        <label for="cost" class="form-label">Cost</label>
                        <input type="number" class="form-control" id="cost" name="cost" required>
                      </div>
                      <div class="mb-3">
                        <label for="sellingPrice" class="form-label">Selling Price</label>
                        <input type="number" class="form-control" id="sellingPrice" name="sellingPrice" required>
                      </div>
                      <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" required>
                      </div>
                      <div class="mb-3">
                        <label for="reorderLevel" class="form-label">Reorder Level</label>
                        <input type="number" class="form-control" id="reorderLevel" name="reorderLevel" required>
                      </div>
                      <div class="mb-3">
                        <label for="supplierInfo" class="form-label">Supplier Info</label>
                        <input type="text" class="form-control" id="supplierInfo" name="supplierInfo" required>
                      </div>
                      <div class="mb-3">
                        <label for="expiryDate" class="form-label">Expiry Date</label>
                        <input type="date" class="form-control" id="expiryDate" name="expiryDate" required>
                      </div>
                      <button type="submit" class="btn btn-primary">Add Product</button>
                    </form>
                  </div>

                  <!-- Scrollable Product List Panel -->
                  <div class="product-list-panel">
                    <div class="table-responsive" style="max-height: 500px; overflow-y: auto; border: 1px solid #dee2e6; border-radius: 0.25rem;">
                      <%
                          Product_Pojo pojo = new Product_Pojo();
                          @SuppressWarnings("unchecked")
                          List<Product_Pojo> productList = (List<Product_Pojo>) request.getAttribute("productList");
                      %>
                      <table class="table table-bordered table-hover mb-0">
                        <thead class="table-dark sticky-top">
                          <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Cost</th>
                            <th>Selling Price</th>
                            <th>Stock</th>
                            <th style="min-width: 150px;">Actions</th>
                          </tr>
                        </thead>
                        <tbody>
                          <% if (productList != null && !productList.isEmpty()) { %>
                            <% for (Product_Pojo product : productList) { %>
                              <tr>
                                <td><%= product.getId() %></td>
                                <td><%= product.getP_Name() %></td>
                                <td><%= product.getP_Category() %></td>
                                <td><%= product.getP_Cost() %></td>
                                <td><%= product.getP_SellingPrice() %></td>
                                <td><%= product.getP_Stock() %></td>
                                <td>
                                  <button class="btn btn-sm btn-primary" onclick="toggleEditForm(<%= product.getId() %>)">Edit</button>
                                  <a href="ProductController?action=delete&id=<%= product.getId() %>" 
                                     class="btn btn-sm btn-danger"
                                     onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                                </td>
                              </tr>
                              <!-- Edit Form Row -->
                              <tr id="editForm-<%= product.getId() %>" class="edit-form">
                                <td colspan="7">
                                  <form action="ProductController" method="POST">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= product.getId() %>">
                                    <div class="mb-3">
                                      <label for="editName-<%= product.getId() %>" class="form-label">Product Name</label>
                                      <input type="text" class="form-control" id="editName-<%= product.getId() %>" name="name" value="<%= product.getP_Name() %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editCategory-<%= product.getId() %>" class="form-label">Category</label>
                                      <input type="text" class="form-control" id="editCategory-<%= product.getId() %>" name="category" value="<%= product.getP_Category() %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editCost-<%= product.getId() %>" class="form-label">Cost</label>
                                      <input type="number" class="form-control" id="editCost-<%= product.getId() %>" name="cost" value="<%= product.getP_Cost() %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editSellingPrice-<%= product.getId() %>" class="form-label">Selling Price</label>
                                      <input type="number" class="form-control" id="editSellingPrice-<%= product.getId() %>" name="sellingPrice" value="<%= product.getP_SellingPrice() %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editStock-<%= product.getId() %>" class="form-label">Stock</label>
                                      <input type="number" class="form-control" id="editStock-<%= product.getId() %>" name="stock" value="<%= product.getP_Stock() %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editReorderLevel-<%= product.getId() %>" class="form-label">Reorder Level</label>
                                      <input type="number" class="form-control" id="editReorderLevel-<%= product.getId() %>" name="reorderLevel" value="<%= product.getP_ReorderLevel() %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editSupplierInfo-<%= product.getId() %>" class="form-label">Supplier Info</label>
                                      <%
                                          String supplierInfoJson = product.getP_SupplierInfo();
                                          String supplierValue = "";
                                          if (supplierInfoJson != null && supplierInfoJson.contains("\"Supplier\":\"")) {
                                              supplierValue = supplierInfoJson.split("\"Supplier\":\"")[1].split("\"")[0];
                                          }
                                          if (supplierValue == null || supplierValue.isEmpty()) {
                                              supplierValue = "";
                                          }
                                      %>
                                      <input type="text" class="form-control" id="editSupplierInfo-<%= product.getId() %>" name="supplierInfo" value="<%= supplierValue %>" required>
                                    </div>
                                    <div class="mb-3">
                                      <label for="editExpiryDate-<%= product.getId() %>" class="form-label">Expiry Date</label>
                                      <input type="date" class="form-control" id="editExpiryDate-<%= product.getId() %>" name="expiryDate" value="<%= product.getP_ExpiryDate() %>" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Update Product</button>
                                  </form>
                                </td>
                              </tr>
                            <% } %>
                          <% } else { %>
                            <tr>
                              <td colspan="7" class="text-center">No products available</td>
                            </tr>
                          <% } %>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
  </body>
</html>