<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Login</title>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />

        <!-- Bootstrap CSS v5.2.1 -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
        />
    </head>
    <style>
    
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');
        body {
            background: url('images/file.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Poppins;
        }
        .poppins-regular {
        font-family: "Poppins", serif;
        font-weight: 400;
        font-style: normal;
        }
        div.container{
            margin-top: 10%;
            width: 35%;
        }


        
    </style>

    <body>
        <header>
            <!-- place navbar here -->
        </header>
        <main>
            <div class="container " style="background: rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 3, 0.37);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.29);
            
            padding: 20px;
            text-align: center;">
            <img
                src="images/tj.jpg"
                class=" rounded-circle"
                alt=""
                height="60"
                width="60"
            />
            <div class="mt-2" style="font-family: Poppins ;font-weight: 600; font-size: 20px; color: white;">
            <span>Sign in to your account</span>
            </div>
            <form action="Login" method="post">
                <div class="form-floating mb-3 mt-3"  >
                    <input
                        type="text"
                        class="form-control"
                        name="pname"
                        id="formId1"
                        placeholder="Enter your username"
                    />
                    <label for="formId1" >Username</label>
                </div>
                <div class=" form-floating mb-3 mt-4" name="hi">
                    <input
                        type="password"
                        class="form-control"
                        name="ppass"
                        id=""
                        placeholder=""
                    />
                    <label for="" class="form-label">Password</label>
                </div>
                <div class="form-floating mb-3">
                    <input
                        type="text"
                        class="form-control"
                        name="role"
                        id=""
                        placeholder=""
                    />
                    <label for="formId1">Enter Role: Admin, Regular</label>
                </div>
                <div><button type="submit" class="btn btn-primary col-12 "  style="font-family: Poppins ;font-weight: 600; font-size: 20px;">Login</button></div>
                <div class="mt-3" style="font-family: Poppins ;font-weight: 500; font-size: 17px; color: white;">
                    <span>Don't have an Account ? <a href="Register.jsp" style="color: rgb(0, 0, 0);">Register</a></span>
                </div>
                
                
            </form>
            </div>
        </main>
        <footer>
            <!-- place footer here -->
        </footer>
        <!-- Bootstrap JavaScript Libraries -->
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"
        ></script>
    </body>
</html>
    