<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Login - LAMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center;font-family:'Segoe UI',sans-serif;}
    .card{border-radius:18px;box-shadow:0 12px 40px rgba(0,0,0,.15);border:none;padding:10px;}
    .btn-login{background:linear-gradient(135deg,#667eea,#764ba2);border:none;border-radius:25px;padding:10px;font-weight:600;}
    .btn-login:hover{opacity:.9;transform:translateY(-1px);}
  </style>
</head><body>
<div class="card" style="width:400px">
  <div class="card-body p-4">
    <h4 class="text-center mb-1">Welcome Back</h4>
    <p class="text-center text-muted mb-4">Leave & Attendance Management</p>

    <c:if test="${param.error != null}">
      <div class="alert alert-danger py-2">Invalid username or password.</div>
    </c:if>
    <c:if test="${param.logout != null}">
      <div class="alert alert-success py-2">You have been logged out.</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" class="form-control" name="username" autofocus required>
      </div>
      <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" class="form-control" name="password" required>
      </div>
      <button type="submit" class="btn btn-login btn-primary w-100">Login</button>
    </form>

    <div class="mt-4 p-3 bg-light rounded text-center">
      <small class="text-muted d-block mb-1">Demo Credentials</small>
      <small><strong>Admin:</strong> admin / admin123</small>
    </div>
  </div>
</div>
</body></html>
	