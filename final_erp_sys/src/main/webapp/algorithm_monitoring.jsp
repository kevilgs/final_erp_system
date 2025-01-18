<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Admin Dashboard - Algorithm Monitoring</title>
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
	position: fixed;
}

.sidebar .nav-link {
	color: #ecf0f1;
	transition: all 0.3s ease;
	border-radius: 5px;
	margin-bottom: 5px;
}

.sidebar .nav-link:hover, .sidebar .nav-link.active {
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
	margin-left: 235px;
}

.btn-logout {
	background-color: #e74c3c;
	border-color: #c0392b;
}

.btn-logout:hover {
	background-color: #c0392b;
}

.button-group {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 20px;
}

button {
	padding: 10px 20px;
	background-color: #4CAF50;
	border: none;
	color: white;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #45a049;
}

.output-container {
	border: 1px solid #ccc;
	padding: 10px;
	border-radius: 5px;
	background-color: #f8f8f8;
	white-space: pre-wrap;
	overflow-x: auto;
	word-break: break-word;
	max-width: 100%;
	min-height: 100px;
}

.error-message {
	color: red;
	font-weight: bold;
}

.container-fluid {
	padding: 0; /* Remove extra padding */
	margin: 0; /* Ensure full-width layout */
}
</style>
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
              <a class="nav-link" href="product_management.jsp">
                <i class="bi bi-box-seam me-2"></i>Product Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="algorithm_monitoring.jsp">
                <i class="bi bi-bar-chart me-2"></i>Algorithm Management
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
        <div class="col-md-9 col-lg-10 p-0">
          <!-- Header -->
          <div class="content-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Welcome, Admin</h5>
          </div>

          <!-- Dynamic Content -->
          <div class="main-content" id="main-content">
            <h1>Algorithm Monitoring</h1>

            <form action="Algorithm" method="post">
              <div class="button-group">
                <button type="submit" name="algorithm" value="salesTrend">Sales Trend Analysis</button>
                <button type="submit" name="algorithm" value="profit">Profit Analysis</button>
                <button type="submit" name="algorithm" value="abc">ABC Classification</button>
                <button type="submit" name="algorithm" value="turnover">Inventory Turnover Ratio</button>
                <button type="submit" name="algorithm" value="demandForecast">Demand Forecast</button>
              </div>
            </form>

            <div class="output-container">
              <% if (request.getAttribute("salestrend") != null) { %>
                <h3>Sales Trend Analysis Output:</h3>
                <pre><%= request.getAttribute("salestrend") %></pre>
              <% } else if (request.getAttribute("profitanalysis") != null) { %>
                <h3>Profit Analysis Output:</h3>
                <pre><%= request.getAttribute("profitanalysis") %></pre>
              <% } else if (request.getAttribute("abc") != null) { %>
                <h3>ABC Classification Output:</h3>
                <pre><%= request.getAttribute("abc") %></pre>
              <% } else if (request.getAttribute("turnover") != null) { %>
                <h3>Inventory Turnover Ratio Output:</h3>
                <pre><%= request.getAttribute("turnover") %></pre>
              <% } else if (request.getAttribute("demandForecast") != null) { %>
                <h3>Demand Forecast Output:</h3>
                <pre><%= request.getAttribute("demandForecast") %></pre>
              <% } else if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message">
                  <%= request.getAttribute("errorMessage") %>
                </div>
              <% } %>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
