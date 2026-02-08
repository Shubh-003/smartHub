<%@page import="com.org.SignUpServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page</title>

    <!-- Custom CSS for SignUp Page -->
    <link rel="stylesheet" href="CSS/signUp.css">

    <!-- Bootstrap Icons (for icons like user, lock, etc.) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Bootstrap 5.3.7 CSS (latest Bootstrap styles and components) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <!-- Bootstrap 5.3.7 JS Bundle (includes Popper + JS for Bootstrap components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>
    <!-- External CSS from CodePen (custom styles, animations, etc.) -->
    <link rel="stylesheet" href="https://codepen.io/alexkleinubing/pen/abBzMKe.css">
    <!-- Google Fonts (Poppins Family for modern typography) -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- Bootstrap 4.5.2 CSS (older Bootstrap version, may conflict with Bootstrap 5) -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    

</head>

<body>
    <div class="signup-card">
        <h2>Create Account</h2>

        <!-- Show server-side error or success -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            if (errorMessage != null) {
        %>
            <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
        <% } else if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>

        <!-- Signup Form -->
 			<form action="<%= request.getContextPath() %>/SignUpServlet" method="post">

            <input type="text" name="username" placeholder="Name" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" id="password" name="password" placeholder="Password" required>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>

            <!-- JS warning placeholder -->
            <div id="warning" style="color: red; font-weight: bold; margin-bottom: 10px;"></div>

            <button type="submit">Sign Up</button>
        </form>

        <p>Already have an account? <a href="logIn.jsp">Login</a></p>
        <p>Return to <a href="index.jsp">Home</a></p>
    </div>

</body>

</html>


<!-- email already exist

 -->