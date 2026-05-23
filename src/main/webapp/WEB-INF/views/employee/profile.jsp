<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>My Profile - LAMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    body{background:#f5f7fb;font-family:'Segoe UI',sans-serif;}
    .sidebar{width:220px;min-height:100vh;background:linear-gradient(135deg,#43e97b,#38f9d7);position:fixed;top:0;left:0;}
    .sidebar .brand{padding:24px 20px;border-bottom:1px solid rgba(255,255,255,.2);color:#fff;font-size:1.1rem;font-weight:700;}
    .sidebar a{display:block;color:rgba(255,255,255,.9);text-decoration:none;padding:12px 20px;font-size:.9rem;transition:.2s;}
    .sidebar a:hover,.sidebar a.active{background:rgba(255,255,255,.2);color:#fff;padding-left:28px;}
    .sidebar a i{width:22px;}
    .main{margin-left:220px;padding:28px;}
    .avatar-lg{width:90px;height:90px;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);color:#fff;display:flex;align-items:center;justify-content:center;font-size:2.5rem;font-weight:700;}
    .info-label{font-weight:600;color:#495057;font-size:.85rem;text-transform:uppercase;letter-spacing:.5px;}
    .info-value{color:#212529;font-size:1rem;}
  </style>
</head><body>
<div class="sidebar">
  <div class="brand"><i class="fas fa-user-circle me-2"></i>Employee</div>
  <a href="/employee/dashboard"><i class="fas fa-home"></i> Dashboard</a>
  <a href="/employee/profile" class="active"><i class="fas fa-id-card"></i> My Profile</a>
  <a href="/employee/leaves"><i class="fas fa-calendar-alt"></i> My Leaves</a>
  <a href="/employee/leaves/apply"><i class="fas fa-paper-plane"></i> Apply Leave</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <h4 class="mb-4">My Profile</h4>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-4">
      <div class="d-flex align-items-center gap-4 mb-4 pb-4 border-bottom">
        <div class="avatar-lg">${employee.firstName.substring(0,1)}</div>
        <div>
          <h4 class="mb-1">${employee.fullName}</h4>
          <div class="text-muted">${employee.position}</div>
          <div class="badge bg-primary mt-1">${employee.department.name}</div>
        </div>
      </div>
      <div class="row g-4">
        <div class="col-md-6">
          <div class="info-label">Employee ID</div>
          <div class="info-value">${employee.employeeId}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Email</div>
          <div class="info-value">${employee.email}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Phone</div>
          <div class="info-value">${not empty employee.phone ? employee.phone : '—'}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Department</div>
          <div class="info-value">${employee.department.name}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Position</div>
          <div class="info-value">${not empty employee.position ? employee.position : '—'}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Hire Date</div>
          <div class="info-value">${not empty employee.hireDate ? employee.hireDate : '—'}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Username (Login)</div>
          <div class="info-value">${employee.user.username}</div>
        </div>
        <div class="col-md-6">
          <div class="info-label">Salary</div>
          <div class="info-value">${not empty employee.salary ? '₹'.concat(employee.salary) : '—'}</div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
