<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Order Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* --- Dynamic Background --- */
        body {
            font-family: 'Poppins', sans-serif;
            color: #fff;
            background: linear-gradient(-45deg, #0d0d0d, #1a0c2e, #0d0d0d, #2e1a0c);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            height: 100vh;
            margin: 0;
            display: flex; /* Using Flexbox for centering */
            justify-content: center; /* Horizontally center */
            align-items: center; /* Vertically center */
            overflow: hidden; /* Hide scrollbars */
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* --- Glassmorphism Card --- */
        .glass-card {
            background: rgba(255, 255, 255, 0.05); /* Semi-transparent background */
            backdrop-filter: blur(15px); /* The "frost" effect */
            -webkit-backdrop-filter: blur(15px); /* Safari support */
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            padding: 2.5rem;
            text-align: center;
            animation: fadeIn 1s ease-out; /* Fade-in animation */
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* --- Animated Checkmark --- */
        .checkmark-container {
            width: 100px;
            height: 100px;
            margin: 0 auto 20px auto;
            position: relative;
        }

        .checkmark-circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 3;
            stroke-miterlimit: 10;
            stroke: #28a745;
            fill: none;
            animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
        }

        .checkmark {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: block;
            stroke-width: 3;
            stroke: #fff;
            stroke-miterlimit: 10;
            position: absolute;
            top: 0;
            left: 0;
            box-shadow: inset 0px 0px 0px #28a745;
            animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
        }

        .checkmark-check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
        }

        @keyframes stroke {
            100% { stroke-dashoffset: 0; }
        }
        @keyframes scale {
            0%, 100% { transform: none; }
            50% { transform: scale3d(1.1, 1.1, 1); }
        }
        @keyframes fill {
            100% { box-shadow: inset 0px 0px 0px 50px #28a745; }
        }

        /* --- Content & Button Styling --- */
        h2 {
            font-weight: 600;
            color: #28a745; /* Success Green */
            margin-bottom: 0.5rem;
        }

        p {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 1.5rem;
        }

        .btn-primary {
            background: #6a11cb;
            border: none;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-primary:hover {
            background: #2575fc;
            transform: translateY(-2px);
        }

    </style>
</head>
<body>

    <div class="glass-card">
        <div class="checkmark-container">
            <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
                <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
            </svg>
        </div>

        <h2>Order Placed Successfully!</h2>
        <p>Thank you for your purchase. We'll notify you once it ships.</p>
        <a href="index.jsp" class="btn btn-primary btn-lg mt-3">Continue Shopping</a>
    </div>

</body>
</html>