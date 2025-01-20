<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>

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
	position: fixed;
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
	background-color: #ecf0f1;
	padding: 15px 20px;
	border-bottom: 1px solid #bdc3c7;
}

.main-content {
	padding: 20px;
	background-color: #f9f9f9;
	min-height: calc(100vh - 61px);
	margin-left:235px;
}

.btn-logout {
	background-color: #e74c3c;
	border-color: #c0392b;
}

.btn-logout:hover {
	background-color: #c0392b;
}

.chart-container {
	width: 50% px;
	margin: 20px auto;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 20px;
}
</style>

    <script>
        function jsonToExcel(jsonArray, filename = "data.xlsx") {
            if (!jsonArray || jsonArray.length === 0) return;
            try {
                const worksheet = XLSX.utils.json_to_sheet(jsonArray);
                const workbook = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");
                XLSX.writeFile(workbook, filename);
            } catch (error) {
                console.error("Excel Error:", error);
                alert("Error generating Excel. Check the console.");
            }
        }

        function jsonToPDFMake(jsonArray, algorithm, filename = "data.pdf") {
            if (!jsonArray || jsonArray.length === 0) return;

            try {
                let tableBody = [];
                let contentHeader = "Data Report";

                // Customize based on algorithm
                switch (algorithm) {
                    case "abc":
                        contentHeader = "ABC Classification Report";
                        tableBody = [
                            ["Category", "Item", "Value"], // Table header
                            ...jsonArray.map(obj => [obj.category, obj.item, obj.value])
                        ];
                        break;

                    case "salesTrend":
                        contentHeader = "Sales Trend Report";
                        tableBody = [
                            ["Month", "Sales"], // Table header
                            ...jsonArray.map(obj => [obj.month, obj.sales])
                        ];
                        break;

                    case "productProfitability":
                        contentHeader = "Product Profitability Report";
                        tableBody = [
                            ["Product", "Profitability"], // Table header
                            ...jsonArray.map(obj => [obj.product, obj.profitability])
                        ];
                        break;

                    default:
                        tableBody = [
                            Object.keys(jsonArray[0]),
                            ...jsonArray.map(obj => Object.values(obj))
                        ];
                }

                const documentDefinition = {
                    content: [
                        { text: contentHeader, style: 'header' },
                        {
                            table: { body: tableBody }
                        }
                    ],
                    styles: {
                        header: {
                            fontSize: 18,
                            bold: true,
                            margin: [0, 0, 0, 20]
                        }
                    }
                };

                pdfMake.createPdf(documentDefinition).download(filename);
            } catch (error) {
                console.error("pdfMake Error:", error);
                alert("Error generating PDF. Check the console.");
            }
        }

        function generateReport() {
            const algorithm = document.getElementById("algorithmSelect").value;
            const format = document.getElementById("formatSelect").value;
            const allData = {
                abc: <%= request.getAttribute("abc_classificationData") %>,
                salesTrend: <%= request.getAttribute("salesTrendData") %>,
                turnover: <%= request.getAttribute("inventoryratio") %>,
                productProfitability: <%= request.getAttribute("profitability") %>,
                demandForecast: <%= request.getAttribute("demandForecast") %>
            };

            let dataToUse;
            let filenameBase;

            switch (algorithm) {
                case "abc": dataToUse = allData.abc; filenameBase = "abc"; break;
                case "salesTrend": dataToUse = allData.salesTrend; filenameBase = "sales_trend"; break;
                case "turnover": dataToUse = allData.turnover; filenameBase = "turnover"; break;
                case "productProfitability":
                    dataToUse = (allData.productProfitability?.HighProfitProducts || []).concat(allData.productProfitability?.LowProfitProducts || []);
                    filenameBase = "product_profitability"; break;
                case "demandForecast": dataToUse = allData.demandForecast; filenameBase = "demand_forecast"; break;
                default: alert("Please select an algorithm."); return;
            }

            if (!dataToUse || dataToUse.length === 0) {
                alert("No data available for the selected algorithm.");
                return;
            }

            switch (format) {
                case "excel": jsonToExcel(dataToUse, filenameBase + ".xlsx"); break;
                case "pdfmake": jsonToPDFMake(dataToUse, filenameBase + "_pdfmake.pdf"); break;
                default: alert("Please select a format."); return;
            }
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
					<li class="nav-item"><a class="nav-link"
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
					<li class="nav-item"><a class="nav-link active"
						href="Report_Generation"> <i
							class="bi bi-file-earmark-text me-2"></i>Report Management
					</a></li>
				</ul>
			</nav>

        <!-- Main Content -->
        <div class="col-12">
          

          <!-- Report Generation Section -->
          <div class="main-content" id="main-content">
           <div class="chart-container">
            <label for="algorithmSelect">Select Algorithm:</label>
            <select id="algorithmSelect">
                <option value="">-- Select --</option>
                <option value="abc">ABC Classification</option>
                <option value="salesTrend">Sales Trend Analysis</option>
                <option value="turnover">Inventory Turnover Ratio</option>
                <option value="productProfitability">Product Profitability</option>
                <option value="demandForecast">Demand Forecast</option>
            </select><br><br>

            <label for="formatSelect">Select Format:</label>
            <select id="formatSelect">
                <option value="">-- Select --</option>
                <option value="excel">Excel</option>
                <option value="pdfmake">PDFMAKE</option>
            </select><br><br>

            <button onclick="generateReport()" style="color:blue">Generate Report</button>
            </div>
            
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
