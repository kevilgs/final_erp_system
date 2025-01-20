<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.UserFeedbackPojo" %>
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
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
      body {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  background-color: #ecf0f1;
  margin: 0;
}
.sidebar {
	background-color: #3B1E54;
	color: white;
	height: 100vh;
	position: sticky;
	top: 0;
	overflow-y: auto;
}

.sidebar .nav-link {
	color: white;
	font-size: 16px;
	margin-bottom: 10px;
	transition: background 0.3s ease;
}

.sidebar .nav-link:hover, .sidebar .nav-link.active {
	background-color: #D4BEE4;
	border-radius: 5px;
	color: #EEEEEE;
}
     
      .content-header {
        background-color: #ffffff;
        padding: 15px 20px;
        border-bottom: 1px solid #bdc3c7;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      .container-fluid {
  padding: 0; /* Remove any default padding */
}
      
      .main-content {
  padding: 20px;
  background-color: #f9f9f9;
  min-height: calc(100vh - 61px);
  margin: 0; /* Ensure no margin on main content */
}

      .btn-logout {
        background-color: #e74c3c;
        border-color: #c0392b;
      }
      .btn-logout:hover {
        background-color: #c0392b;
      }
      table {
        background-color: #ffffff;
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      table th {
        background-color: #2c3e50;
        color: white;
      }
      table th, table td {
        text-align: center;
        padding: 10px;
      }
      .ratings-chart-container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      .ratings-chart-container h4 {
        margin-bottom: 20px;
      }
      .navbar-brand {
        font-weight: bold;
        color: #34495e;
      }
      .nav-item {
        transition: transform 0.3s;
      }
      .nav-item:hover {
        transform: scale(1.05);
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
					<li class="nav-item"><a class="nav-link "
						href="Admin_Dashboard"> <i class="bi bi-speedometer2 me-2"></i>Dashboard
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="UserManagement.jsp"> <i class="bi bi-people me-2"></i>User
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="product_management.jsp"> <i class="bi bi-box-seam me-2"></i>Product
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="algorithm_monitoring.jsp"> <i class="bi bi-cpu me-2"></i>Algorithm
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link active" href="feedback.jsp">
							<i class="bi bi-chat-dots me-2"></i>Feedback Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="Report_Generation"> <i
							class="bi bi-file-earmark-text me-2"></i>Report Management
					</a></li>
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
            
            <!-- Feedback Table -->
            <h4 class="mb-4">Feedback Data</h4>
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th></th>
                  <th>User</th>
                  <th>Feedback</th>
                  <th>Rating</th>
                </tr>
              </thead>
              <tbody>
                <%
                // Fetch feedback list from request attribute (passed from servlet)
                                  List<UserFeedbackPojo> feedbackList = (List<UserFeedbackPojo>) request.getAttribute("feedbackList");
                                  if (feedbackList != null && !feedbackList.isEmpty()) {
                                    for (int i = 0; i < feedbackList.size(); i++) {
                                      UserFeedbackPojo feedback = feedbackList.get(i);
                %>
                  <tr>
                    <td><%=i + 1%></td>
                    <td><%=feedback.getCustomerId()%></td>
                    <td><%=feedback.getComments()%></td>
                    <td><%=feedback.getRatings()%></td>
                  </tr>
                <%
                }
                                  } else {
                %>
                  <tr>
                    <td colspan="4" class="text-center">No feedback data available</td>
                  </tr>
                <%
                }
                %>
              </tbody>
            </table>

            <!-- Ratings Graph -->
            <div class="ratings-chart-container">
              <h4>Ratings Distribution</h4>
              <canvas id="ratingsChart"></canvas>
              <script>
                // Prepare the ratings data for the chart
                var ratingsCount = [0, 0, 0, 0, 0]; // Array to store counts for ratings 1-5
                
                <%// Loop through feedback list and count ratings
                  if (feedbackList != null && !feedbackList.isEmpty()) {
                    for (UserFeedbackPojo feedback : feedbackList) {
                      int rating = feedback.getRatings();
                      out.println("ratingsCount[" + (rating - 1) + "]++;");
                    }
                  }%>

                var ratingsData = {
                  labels: ["1", "2", "3", "4", "5"],
                  datasets: [{
                    label: "Ratings Distribution",
                    data: ratingsCount,
                    backgroundColor: ['#e74c3c', '	#f9e7ff', '	#fdd3ff', '#dfc2ff', '#d3b4ff'], 
                    borderColor: ['#e74c3c', '	#f9e7ff', '	#fdd3ff', '#dfc2ff', '#d3b4ff'],
                    borderWidth: 1
                  }]
                };

                var ctx = document.getElementById('ratingsChart').getContext('2d');
                var ratingsChart = new Chart(ctx, {
                  type: 'bar',
                  data: ratingsData,
                  options: {
                    responsive: true,
                    scales: {
                      x: { beginAtZero: true },
                      y: { beginAtZero: true }
                    }
                  }
                });
              </script>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>