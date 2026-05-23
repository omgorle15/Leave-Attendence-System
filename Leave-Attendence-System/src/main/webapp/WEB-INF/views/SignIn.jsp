<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(to right, #4facfe, #00f2fe);
        height: 100vh;
    }

    .card {
        border-radius: 15px;
    }

    .form-container {
        height: 100vh;
    }
</style>

</head>
<body>

<div class="container d-flex justify-content-center align-items-center form-container">
    
    <div class="col-md-4">
        <div class="card shadow p-4">
            
            <h3 class="text-center mb-4">Sign In</h3>

            <!-- Login Form -->
            <form action="/login" method="post">

                <!-- Email -->
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <!-- Role -->
                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select" required>
                        <option value="">Select Role</option>
                        <option value="Employee">Employee</option>
                        <option value="Admin">Admin</option>
                        <option value="Manager">Manager</option>
                    </select>
                </div>

                <!-- Submit -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Sign In</button>
                </div>

                <!-- Links -->
                <div class="text-center mt-3">
                    Don't have an account? 
                    <a href="/SignUp">Sign Up</a>
                </div>

            </form>

        </div>
    </div>

</div>

</body>
</html>