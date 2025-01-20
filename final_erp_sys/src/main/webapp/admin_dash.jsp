<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="java.util.List"%>


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
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<style>
body {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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

/* Cards Section */
.cards-container {
	display: flex;
	gap: 1rem;
}

.card {
	background: linear-gradient(135deg, #ff7eb3, #ff758c);
	color: white;
	flex: 1;
	border-radius: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
	padding: 1rem;
	text-align: center;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	cursor: pointer;
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
}

.card i {
	font-size: 3rem;
	margin-bottom: 0.5rem;
}

.card h3 {
	font-size: 1.5rem;
	margin-bottom: 0.5rem;
}

.card p {
	font-size: 1.8rem;
	font-weight: bold;
}

/* Bright Color Variants */
.total-revenue {
	background: linear-gradient(135deg, #ff7eb3, #ff758c);
}

.total-users {
	background: linear-gradient(135deg, #6a85b6, #bac8e0);
}

.total-products {
	background: linear-gradient(135deg, #6decb9, #3cd28d);
}

/* Charts Section */
.chart-container {
	background: #pink;
	padding: 15px;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}
/* Reduce Height of ABC Classification Chart */
#abcChart {
	max-height: 400px; /* Adjust as needed */
	max-width: 100%; /* Keep it responsive */
}

#demandForecastChart {
	max-height: 300px; /* Adjust as needed */
	max-width: 100%; /* Keep it responsive */
}

#turnoverChart {
	max-height: 250px; /* Adjust as needed */
	max-width: 100%; /* Keep it responsive */
}
/* Class badge styles */
.class-badge {
	display: inline-block;
	padding: 0.25em 0.75em;
	font-size: 0.875em;
	font-weight: 600;
	line-height: 1;
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-radius: 0.25rem;
}

.class-A {
	background-color: #d4edda;
	color: #155724;
}

.class-B {
	background-color: #fff3cd;
	color: #856404;
}

.class-C {
	background-color: #f8d7da;
	color: #721c24;
}

.output-container {
	border: 1px solid #ccc;
	padding: 5px;
	border-radius: 5px;
	background-color: #f8f8f8;
	overflow-x: auto;
	word-break: break-word;
	max-width: 100%;
	min-height: 50px;
}

.error-message {
	color: red;
	font-weight: bold;
}

/* New styles for the table */
.table-container {
	max-height: 400px; /* Adjust the max height as needed */
	overflow-y: auto; /* Enable vertical scrolling for large tables */
	position: relative;
	margin-top: 10px;
	border: 1px solid #d1d1d1;
	/* Add a subtle border around the table container */
	border-radius: 8px; /* Smooth corners for the container */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	/* Subtle shadow for a floating effect */
	background-color: #fff; /* Background color for the container */
	padding: 10px; /* Padding for a cleaner look */
}

/* Styling the table */
.table {
	width: 90%; /* Slightly increase table width */
	margin: 0 auto; /* Center the table horizontally */
	table-layout: fixed; /* Prevent cells from expanding too much */
	font-size: 14px; /* Maintain a clean font size */
	border-collapse: collapse; /* Remove double borders */
	color: #333; /* Text color for readability */
	background-color: #f9f9f9; /* Subtle background for the table */
}

/* Table headers */
.table thead th {
	position: sticky;
	top: 0;
	background-color: #3498db; /* Nice blue color for the header */
	color: #fff; /* White text for contrast */
	z-index: 1;
	text-align: center; /* Center align headers */
	padding: 12px; /* Increase padding for better spacing */
	font-weight: 600; /* Bold text for emphasis */
	font-size: 15px; /* Slightly larger font for headers */
	border-bottom: 2px solid #2c82c9; /* Bold separator line */
	text-transform: uppercase; /* Uppercase for headers */
}

/* Table cells */
.table th, .table td {
	word-wrap: break-word;
	max-width: 150px; /* Adjust width for content */
	text-align: center; /* Center align content */
	padding: 10px; /* Comfortable padding */
	border: 1px solid #dcdcdc; /* Subtle border around cells */
}

/* Add subtle animations for a modern look */
.table tbody td {
	transition: color 0.3s, background-color 0.3s;
}

/* Add focus styles */
.table tbody tr:focus-within {
	background-color: #cbe1f5; /* Focus color for keyboard navigation */
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
		salesTrendData
		.append(obj.get("percentage_change").isJsonNull() ? "null" : obj.get("percentage_change").getAsDouble());

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

	String productJson = (String) request.getAttribute("abc_classificationData");

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

	// Extract the top 5 products based on profit margin
	JsonArray allProfitProducts = profitJson.getAsJsonArray("AllProfitProducts");
	List<JsonObject> topProducts = new ArrayList<>();
	for (int i = 0; i < Math.min(5, allProfitProducts.size()); i++) {
		topProducts.add(allProfitProducts.get(i).getAsJsonObject());
	}

	// Prepare data for the chart
	StringBuilder productNames = new StringBuilder("[");
	StringBuilder profitMargins = new StringBuilder("[");

	// Populate top 5 product data
	for (int i = 0; i < topProducts.size(); i++) {
		JsonObject product = topProducts.get(i);
		productNames.append("'").append(product.get("ProductName").getAsString()).append("'");
		profitMargins.append(product.get("ProfitMargin").getAsDouble());
		if (i < topProducts.size() - 1) {
			productNames.append(", ");
			profitMargins.append(", ");
		}
	}

	productNames.append("]");
	profitMargins.append("]");

	// Set these values as request attributes for dynamic rendering
	request.setAttribute("productNames", productNames.toString());
	request.setAttribute("profitMargins", profitMargins.toString());
	%>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<nav class="col-md-3 col-lg-2 sidebar d-flex flex-column p-3">
				<h4 class="text-center mb-4">Admin Panel</h4>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active"
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
					<li class="nav-item"><a class="nav-link" href="feedback.jsp">
							<i class="bi bi-chat-dots me-2"></i>Feedback Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="Report_Generation"> <i
							class="bi bi-file-earmark-text me-2"></i>Report Management
					</a></li>
				</ul>
			</nav>

			<!-- Main Content -->
			<div class="col-md-9 col-lg-10 p-4">
				<!-- Cards Section -->
				<div class="cards-container d-flex justify-content-between mb-4">
					<!-- Total Revenue Card -->
					<div class="card text-center total-revenue">
						<i class="bx bx-dollar-circle bx-lg"></i>
						<h3>Total Revenue</h3>
						<p>$ <%= request.getAttribute("totalRevenue") %></p>
					</div>

					<!-- Total Users Card -->
					<div class="card text-center total-users">
						<i class="bx bx-user bx-lg"></i>
						<h3>Total Users</h3>
						<p><%= request.getAttribute("totalUsers") %></p>
					</div>

					<!-- Total Products Card -->
					<div class="card text-center total-products">
						<i class="bx bx-box bx-lg"></i>
						<h3>Total Products</h3>
						<p><%= request.getAttribute("totalProducts") %></p>
					</div>
				</div>

				<!-- Charts Section -->
				<div class="main-content row" id="main-content">
					<!-- Monthly Sales Trend Analysis -->
					<div class="col-12 chart-container mb-4">
						<h2>Monthly Sales Trend Analysis</h2>
						<canvas id="salesTrendChart"></canvas>
					</div>

					<!-- ABC Classification Analysis -->
					<div class="col-md-6 chart-container mb-4">
						<h2>ABC Classification Analysis</h2>
						<canvas id="abcChart" style="width: 100%; height: 100px;"></canvas>
					</div>

					<div class="col-md-6 chart-container mb-4">

						<%
						// Fetching the "abc" data from request attributes
						String jsonData2 = (String) request.getAttribute("abc_classificationData");
						List<Map<String, String>> resultList = null;

						if (request.getAttribute("abc") != null) {
							jsonData2 = (String) request.getAttribute("abc");
						} else if (request.getAttribute("errorMessage") != null) {
							out.print("<div class='error-message'>" + request.getAttribute("errorMessage") + "</div>");
						}

						if (!jsonData2.isEmpty()) {
							Gson gson2 = new Gson();

							// Parse JSON data into a list of maps
							if (jsonData2.startsWith("{")) {
								Map<String, String> singleResult = gson2.fromJson(jsonData2, Map.class);
								resultList = new ArrayList<>();
								resultList.add(singleResult);
							} else {
								resultList = gson2.fromJson(jsonData2, List.class);
							}
						}

						if (resultList != null && !resultList.isEmpty()) {
						%>
						<div class="table-container">
							<table class="table table-bordered">
								<thead>
									<tr>
										<%
										// Dynamically create table headers
										Set<String> keys = resultList.get(0).keySet();
										for (String key : keys) {
										%>
										<th><%=key%></th>
										<%
										}
										%>
									</tr>
								</thead>
								<tbody>
									<%
									// Populate table rows with data
									for (Map<String, String> row : resultList) {
									%>
									<tr>
										<%
										for (String key : row.keySet()) {
											Object value = row.get(key);
										%>
										<td>
											<%
											if (value instanceof Integer) {
											%> <%=(Integer) value%> <%
 } else {
 %> <%=value.toString()%> <%
 }
 %>
										</td>
										<%
										}
										%>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>

						<%
						} else {
						%>
						<p>No data available to display.</p>
						<%
						}
						%>

                   </div>
						<!-- Demand Forecast -->
					<div class="col-md-6 chart-container mb-4 ">
						<h2>Demand Forecast</h2>
						<canvas id="demandForecastChart" style="width: 100px;"></canvas>
					</div>

					<!-- Inventory Turnover Ratio -->
					<div class="col-md-6 chart-container mb-4">
						<h2>Inventory Turnover Ratio</h2>
						<canvas id="turnoverChart"></canvas>
					</div>

					<!-- Product Profit Comparison -->
					<div class="col-12 chart-container mb-4">
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
                tension: 0
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
    
 // Initial Chart Rendering
    const profitCtx = document.getElementById('profitChart').getContext('2d');
    let profitChart = new Chart(profitCtx, {
        type: 'bar',
        data: {
            labels: <%= productNames %>, // Dynamic product names
            datasets: [
                {
                    label: 'Profit Margin (%)',
                    data: <%= profitMargins %>, // Dynamic profit margins
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
                    text: 'Top 5 Products by Profit Margin'
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Products'
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

    // Search Functionality
    let searchInput = document.getElementById('searchInput');
    let searchSuggestions = document.getElementById('searchSuggestions');

    // Fetch product names for autocomplete
    let productNamesList = <%= profitJson.getAsJsonArray("AllProfitProducts").toString() %>;

    // Autocomplete Suggestions
    searchInput.addEventListener('input', function () {
        let query = searchInput.value.toLowerCase();
        searchSuggestions.innerHTML = '';

        if (query.length > 0) {
            let suggestions = productNamesList.filter(product => 
                product.ProductName.toLowerCase().includes(query)
            );

            suggestions.forEach(suggestion => {
                let suggestionItem = document.createElement('div');
                suggestionItem.textContent = suggestion.ProductName;
                suggestionItem.classList.add('suggestion-item');
                suggestionItem.addEventListener('click', function () {
                    addProductToChart(suggestion);
                });
                searchSuggestions.appendChild(suggestionItem);
            });
        }
    });

    // Add Product to Chart
    function addProductToChart(product) {
        // Replace the sixth product with the new selection
        profitChart.data.labels[5] = product.ProductName;
        profitChart.data.datasets[0].data[5] = product.ProfitMargin;

        profitChart.update();
    }

 
    
    </script>
</body>
</html>