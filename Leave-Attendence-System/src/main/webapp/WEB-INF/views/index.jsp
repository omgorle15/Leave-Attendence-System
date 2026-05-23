<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leave & Attendance System</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        margin: 0;
        padding: 0;
    }

    /* Background Image */
    .hero-section {
        height: 100vh;
        background: url('images/bg.jpg') no-repeat center center/cover;
        position: relative;
    }

    /* Dark overlay */
    .overlay {
        position: absolute;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.6);
    }

    /* Center Content */
    .content {
        position: relative;
        z-index: 2;
        color: white;
        text-align: center;
        top: 50%;
        transform: translateY(-50%);
    }

    .btn-custom {
        padding: 10px 25px;
        border-radius: 30px;
    }
</style>

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand fw-bold" href="#">Leave System</a>

    <div class="ms-auto">
        <a href="login.jsp" class="btn btn-outline-light me-2">Sign In</a>
        <a href="SignUp" class="btn btn-warning">Sign Up</a>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero-section">
    <div class="overlay"></div>

    <div class="content">
        <h1 class="display-4 fw-bold">Welcome to Leave & Attendance System</h1>
        <p class="lead mt-3">Manage your leaves and track attendance easily</p>

        <a href="/SignUp" class="btn btn-primary btn-custom mt-3">Get Started</a>
    </div>
</div>

</body>
</html>