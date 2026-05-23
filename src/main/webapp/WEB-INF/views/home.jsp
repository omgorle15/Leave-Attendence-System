<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave & Attendance Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .hero-section {
            padding: 100px 0;
            color: white;
        }
        .feature-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin: 20px;
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .btn-custom {
            background: #ff6b6b;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s;
        }
        .btn-custom:hover {
            background: #ff5252;
            color: white;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">LAMS</a>
            <div class="ms-auto">
                <a href="/login" class="btn btn-outline-light">Login</a>
            </div>
        </div>
    </nav>
    
    <div class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 mb-4">Leave & Attendance Management System</h1>
            <p class="lead mb-5">Streamline your workforce management with our comprehensive solution</p>
            
            <div class="row mt-5">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="display-4 mb-3">📊</div>
                        <h3>Track Attendance</h3>
                        <p>Real-time attendance tracking with check-in/check-out system</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="display-4 mb-3">📅</div>
                        <h3>Manage Leaves</h3>
                        <p>Submit and track leave requests efficiently</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="display-4 mb-3">👥</div>
                        <h3>Employee Management</h3>
                        <p>Complete employee profile management</p>
                    </div>
                </div>
            </div>
            
            <a href="/login" class="btn-custom d-inline-block mt-4">Get Started</a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>