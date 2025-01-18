<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Dashboard</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />

<!-- Other head content -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
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
	margin-left: 235px; /* Adjust according to the sidebar's width */
	padding: 20px;
}

.btn-logout {
	background-color: #e74c3c;
	border-color: #c0392b;
}

.btn-logout:hover {
	background-color: #c0392b;
}

.chart-container {
	max-width: 100% px;
	width: 100% px;
	margin: 20px auto;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.container-fluid {
	padding: 0; /* Remove extra padding */
	margin: 0; /* Ensure full-width layout */
}

#specific-chart-container {
	max-width: 400px; /* Adjust the size */
	margin: 0 auto; /* Optional: Center the chart */
}

#specific-chart-container canvas {
	width: 100% !important; /* Ensure it resizes within the container */
	height: auto !important; /* Maintain aspect ratio */
}
</style>
</head>
<body>
	<%
	String jsonData = (String) request.getAttribute("salesTrendData");
			        Gson gson = new Gson();
			        JsonArray salesTrendArray = JsonParser.parseString(jsonData).getAsJsonArray();
			StringBuilder salesTrendLabels = new StringBuilder();
			StringBuilder salesTrendData = new StringBuilder();

			salesTrendLabels.append("[");
			salesTrendData.append("[");

			for (int i = 0; i < salesTrendArray.size(); i++) {
				JsonObject obj = salesTrendArray.get(i).getAsJsonObject();
				salesTrendLabels.append("'" + obj.get("month").getAsString() + "'");
				salesTrendData.append(obj.get("percentage_change").isJsonNull() ? "null"
						: obj.get("percentage_change").getAsDouble());

				if (i < salesTrendArray.size() - 1) {
					salesTrendLabels.append(",");
					salesTrendData.append(",");
				}
			}
			salesTrendLabels.append("]");
			salesTrendData.append("]");

			String abcData = (String) request.getAttribute("abc_classificationData");
			JsonArray abcArray = JsonParser.parseString(abcData).getAsJsonArray();
			Map<String, Integer> abcTotals = new HashMap<>();

			// Count the number of products in each class instead of summing product IDs
			for (int i = 0; i < abcArray.size(); i++) {
			    JsonObject obj = abcArray.get(i).getAsJsonObject();
			    String className = obj.get("class").getAsString();
			    // Increment the count by 1 for each product instead of adding the product ID
			    abcTotals.put(className, abcTotals.getOrDefault(className, 0) + 1);
			}

			StringBuilder abcLabels = new StringBuilder("[");
			StringBuilder abcDataPoints = new StringBuilder("[");

			int count = 0;
			for (Map.Entry<String, Integer> entry : abcTotals.entrySet()) {
			    abcLabels.append("'Class " + entry.getKey() + "'");
			    abcDataPoints.append(entry.getValue());
			    if (++count < abcTotals.size()) {
			        abcLabels.append(",");
			        abcDataPoints.append(",");
			    }
			}
			abcLabels.append("]");
			abcDataPoints.append("]");
			
			
			
		    String demandForecastData = (String) request.getAttribute("demandForecast"); // Replace with actual attribute
		    JsonArray demandForecastArray = JsonParser.parseString(demandForecastData).getAsJsonArray();

		    // Prepare data for the chart
		    StringBuilder demandForecastLabels = new StringBuilder("[");
		    StringBuilder demandForecastDataPoints = new StringBuilder("[");

		    for (int i = 0; i < demandForecastArray.size(); i++) {
		        JsonObject obj = demandForecastArray.get(i).getAsJsonObject();
		        demandForecastLabels.append("'").append(obj.get("ProductName").getAsString()).append("'");
		        demandForecastDataPoints.append(obj.get("PredictedDemand").getAsDouble());
		        if (i < demandForecastArray.size() - 1) {
		            demandForecastLabels.append(", ");
		            demandForecastDataPoints.append(", ");
		        }
		    }
		    demandForecastLabels.append("]");
		    demandForecastDataPoints.append("]");
		    
		    
		    String turnoverData = (String) request.getAttribute("inventoryratio"); // Replace with actual attribute
		    JsonArray turnoverArray = JsonParser.parseString(turnoverData).getAsJsonArray();

		    // Prepare data for the chart
		    StringBuilder turnoverYears = new StringBuilder("[");
		    StringBuilder turnoverRatios = new StringBuilder("[");

		    for (int i = 0; i < turnoverArray.size(); i++) {
		        JsonObject obj = turnoverArray.get(i).getAsJsonObject();
		        turnoverYears.append(obj.get("Year").getAsInt());
		        turnoverRatios.append(obj.get("Ratio").getAsDouble());
		        if (i < turnoverArray.size() - 1) {
		            turnoverYears.append(", ");
		            turnoverRatios.append(", ");
		        }
		    }
		    turnoverYears.append("]");
		    turnoverRatios.append("]");
		    
		    
		    String profitData = (String) request.getAttribute("profitability"); // Replace with actual attribute
		    JsonObject profitJson = JsonParser.parseString(profitData).getAsJsonObject();

		    JsonArray lowProfitProducts = profitJson.getAsJsonArray("LowProfitProducts");
		    JsonArray highProfitProducts = profitJson.getAsJsonArray("HighProfitProducts");

		    // Prepare data for the chart
		    StringBuilder productNames = new StringBuilder("[");
		    StringBuilder lowProfitMargins = new StringBuilder("[");
		    StringBuilder highProfitMargins = new StringBuilder("[");

		    int productCount = Math.min(lowProfitProducts.size(), highProfitProducts.size()); // Ensure pairing

		    for (int i = 0; i < productCount; i++) {
		        JsonObject lowProduct = lowProfitProducts.get(i).getAsJsonObject();
		        JsonObject highProduct = highProfitProducts.get(i).getAsJsonObject();

		        productNames.append("'").append(lowProduct.get("ProductName").getAsString()).append(" vs ")
		                     .append(highProduct.get("ProductName")).append("'");
		        lowProfitMargins.append(lowProduct.get("ProfitMargin").getAsDouble());
		        highProfitMargins.append(highProduct.get("ProfitMargin").getAsDouble());

		        if (i < productCount - 1) {
		            productNames.append(", ");
		            lowProfitMargins.append(", ");
		            highProfitMargins.append(", ");
		        }
		    }

		    productNames.append("]");
		    lowProfitMargins.append("]");
		    highProfitMargins.append("]");
	%>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<nav class="col-md-3 col-lg-2 sidebar d-flex flex-column p-3">
				<h4 class="text-center mb-4">Admin Panel</h4>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active"
						href="admin_dash.jsp"> <i class="bi bi-speedometer2 me-2"></i>Dashboard
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="user_management.jsp"> <i class="bi bi-people me-2"></i>User
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="product_management.jsp"> <i class="bi bi-box-seam me-2"></i>Product
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="algorithm_monitoring.jsp"> <i class="bi bi-people me-2"></i>Algorithm
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link "
						href="feedback_management.jsp"> <i
							class="bi bi-chat-dots me-2"></i>Feedback Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="Report_Generation"> <i
							class="bi bi-file-earmark-text me-2"></i>Report Management
					</a></li>
				</ul>
			</nav>

			<!-- Main Content -->
			<div class="col-md-12 col-lg-12 p-0">
				<!-- Header -->
				<div
					class="content-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0">Welcome, Admin</h5>
				</div>

				<!-- Dynamic Content -->
				<div class="main-content" id="main-content">
					<div class="chart-container">
						<h2>Monthly Sales Trend Analysis</h2>
						<canvas id="salesTrendChart"></canvas>
					</div>
					<div class="chart-container" id="specific-chart-container">
						<h2>ABC Classification Analysis</h2>
						<canvas id="abcChart"> </canvas>
					</div>
					<div class="chart-container">
						<h2>Demand Forecast</h2>
						<canvas id="demandForecastChart"></canvas>
					</div>
					<div class="chart-container">
						<h2>Inventory Turnover Ratio</h2>
						<canvas id="turnoverChart"></canvas>
					</div>
					<div class="chart-container">
						<h2>Product Profit Comparison</h2>
						<canvas id="profitChart"></canvas>
					</div>


				</div>

			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
    const salesTrendCtx = document.getElementById('salesTrendChart').getContext('2d');
    const salesTrendChart = new Chart(salesTrendCtx, {
        type: 'line',
        data: {
            labels: <%= salesTrendLabels.toString() %>,
            datasets: [{
                label: 'Percentage Change',
                data: <%= salesTrendData.toString() %>,
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top' },
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            const value = tooltipItem.yLabel;
                            if (value === null || value === undefined) {
                                return 'No data';
                            }
                            return value + '%';
                        }
                    }
                }

            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
    
    const abcCtx = document.getElementById('abcChart').getContext('2d');
    const abcChart = new Chart(abcCtx, {
        type: 'pie',
        data: {
            labels: <%= abcLabels.toString() %>,
            datasets: [{
                data: <%= abcDataPoints.toString() %>,
                backgroundColor: ['#ff6384', '#36a2eb', '#cc65fe'],
                hoverOffset: 4
            }]
        }
    });
    
    const demandForecastCtx = document.getElementById('demandForecastChart').getContext('2d');

    // Create the bar chart
    const demandForecastChart = new Chart(demandForecastCtx, {
        type: 'bar', // Bar chart
        data: {
            labels: <%= demandForecastLabels.toString() %>, // Dynamic product labels
            datasets: [{
                label: 'Predicted Demand',
                data: <%= demandForecastDataPoints.toString() %>, // Dynamic demand data
                backgroundColor: [
                    '#ff6384', '#36a2eb', '#cc65fe', '#ffce56', '#4bc0c0', '#9966ff'
                ],
                borderColor: [
                    '#ff6384', '#36a2eb', '#cc65fe', '#ffce56', '#4bc0c0', '#9966ff'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true // Start y-axis at 0
                }
            }
        }
    });
    
    const turnoverCtx = document.getElementById('turnoverChart').getContext('2d');

    // Create the line chart
    const turnoverChart = new Chart(turnoverCtx, {
        type: 'line', // Line chart
        data: {
            labels: <%= turnoverYears.toString() %>, // Dynamic years
            datasets: [{
                label: 'Turnover Ratio',
                data: <%= turnoverRatios.toString() %>, // Dynamic ratio data
                fill: false, // No area fill under the line
                borderColor: '#36a2eb', // Line color
                backgroundColor: '#36a2eb', // Point color
                tension: 0.1 // Smooth curve for the line
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top'
                },
                title: {
                    display: true,
                    text: 'Turnover Ratio Over the Years'
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Year'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Ratio'
                    }
                }
            }
        }
    });
    
    const profitCtx = document.getElementById('profitChart').getContext('2d');

    // Create the grouped bar chart
    const profitChart = new Chart(profitCtx, {
        type: 'bar',
        data: {
            labels: <%= productNames.toString() %>, // Dynamic product names
            datasets: [
                {
                    label: 'Low Profit Products',
                    data: <%= lowProfitMargins.toString() %>, // Dynamic low profit margins
                    backgroundColor: '#ff6384'
                },
                {
                    label: 'High Profit Products',
                    data: <%= highProfitMargins.toString() %>, // Dynamic high profit margins
                    backgroundColor: '#36a2eb'
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top'
                },
                title: {
                    display: true,
                    text: 'Profit Margin Comparison Between Products'
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Product Comparison'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Profit Margin (%)'
                    }
                }
            }
        }
    });
    
    
   

    		
    
    
    
    </script>
</body>
</html>