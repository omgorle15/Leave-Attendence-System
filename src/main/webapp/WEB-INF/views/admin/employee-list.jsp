<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Employees - LAMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    body{background:#f5f7fb;font-family:'Segoe UI',sans-serif;}
    .sidebar{width:240px;min-height:100vh;background:linear-gradient(135deg,#667eea,#764ba2);position:fixed;top:0;left:0;}
    .sidebar .brand{padding:24px 20px;border-bottom:1px solid rgba(255,255,255,.15);color:#fff;font-size:1.2rem;font-weight:700;}
    .sidebar a{display:block;color:rgba(255,255,255,.85);text-decoration:none;padding:12px 20px;font-size:.9rem;transition:.2s;}
    .sidebar a:hover,.sidebar a.active{background:rgba(255,255,255,.15);color:#fff;padding-left:28px;}
    .sidebar a i{width:22px;}
    .main{margin-left:240px;padding:28px;}
  </style>
</head><body>
<div class="sidebar">
  <div class="brand"><i class="fas fa-building me-2"></i>LAMS Admin</div>
  <a href="/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
  <a href="/admin/employees" class="active"><i class="fas fa-users"></i> Employees</a>
  <a href="/admin/leaves"><i class="fas fa-calendar-check"></i> Leave Requests</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h4>Employee Management</h4>
    <a href="/admin/employees/new" class="btn btn-primary"><i class="fas fa-user-plus me-1"></i>Add Employee</a>
  </div>
  <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Department</th><th>Position</th><th>Username</th><th>Actions</th></tr></thead>
        <tbody>
          <c:forEach items="${employees}" var="emp">
          <tr>
            <td>${emp.employeeId}</td>
            <td><strong>${emp.fullName}</strong></td>
            <td>${emp.email}</td>
            <td>${emp.phone}</td>
            <td>${emp.department.name}</td>
            <td>${emp.position}</td>
            <td><small class="text-muted">${emp.user.username}</small></td>
            <td>
              <a href="/admin/employees/edit/${emp.id}" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i></a>
              <a href="/admin/employees/delete/${emp.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete this employee?')"><i class="fas fa-trash"></i></a>
            </td>
          </tr>
          </c:forEach>
          <c:if test="${empty employees}">
            <tr><td colspan="8" class="text-center py-4 text-muted">No employees yet. <a href="/admin/employees/new">Add one</a>.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
