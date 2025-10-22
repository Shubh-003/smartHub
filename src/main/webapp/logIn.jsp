<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="CSS/signUp.css">
    <!-- Add CodePen Animation CSS -->
    <link rel="stylesheet" href="https://codepen.io/alexkleinubing/pen/abBzMKe.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
    <!-- bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <!-- Login Form -->
    <div class="signup-card">
    
    <!-- Show error if exists -->
<% String errorMsg = (String) request.getAttribute("errorMessage"); 
   if (errorMsg != null) { %>
    <div class="alert alert-danger mt-2"><%= errorMsg %></div>
<% } %>

        <h2> LogIn</h2>
        <!-- Here we connect to Servlet -->
        <form action="LoginServlet" method="post">
        
            <input type="email" name="email" placeholder="Email Address" required>
            
            <input type="password" name="password" placeholder="Password" required>
            
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="signUp.jsp">Sign Up</a></p>
    </div>
</body>

</html>
