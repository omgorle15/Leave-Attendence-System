<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Dashboard - LAMS</title>
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
    .stat-card{background:#fff;border-radius:12px;padding:22px;box-shadow:0 2px 8px rgba(0,0,0,.07);}
    .stat-icon{width:52px;height:52px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.4rem;color:#fff;}
    .badge-pending{background:#ffc107;color:#000;}
    .badge-approved{background:#28a745;color:#fff;}
    .badge-rejected{background:#dc3545;color:#fff;}
    .alert-flash{margin-bottom:16px;}
  </style>
</head>
<body>
<div class="sidebar">
  <div class="brand"><i class="fas fa-building me-2"></i>LAMS Admin</div>
  <a href="/admin/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
  <a href="/admin/employees"><i class="fas fa-users"></i> Employees</a>
  <a href="/admin/leaves"><i class="fas fa-calendar-check"></i> Leave Requests</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div><h4 class="mb-0">Admin Dashboard</h4><small class="text-muted">Welcome, <sec:authentication property="name"/>!</small></div>
    <a href="/admin/employees/new" class="btn btn-primary"><i class="fas fa-user-plus me-1"></i>Add Employee</a>
  </div>

  <c:if test="${not empty success}">
    <div class="alert alert-success alert-flash">${success}</div>
  </c:if>

  <div class="row g-3 mb-4">
    <div class="col-md-3">
      <div class="stat-card d-flex align-items-center gap-3">
        <div class="stat-icon" style="background:linear-gradient(135deg,#667eea,#764ba2)"><i class="fas fa-users"></i></div>
        <div><div class="fs-4 fw-bold">${totalEmployees}</div><div class="text-muted small">Total Employees</div></div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stat-card d-flex align-items-center gap-3">
        <div class="stat-icon" style="background:linear-gradient(135deg,#ffc107,#ff9800)"><i class="fas fa-clock"></i></div>
        <div><div class="fs-4 fw-bold">${pendingLeaves}</div><div class="text-muted small">Pending Leaves</div></div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stat-card d-flex align-items-center gap-3">
        <div class="stat-icon" style="background:linear-gradient(135deg,#43e97b,#38f9d7)"><i class="fas fa-check-circle"></i></div>
        <div><div class="fs-4 fw-bold">${presentCount}</div><div class="text-muted small">Present Today</div></div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="stat-card d-flex align-items-center gap-3">
        <div class="stat-icon" style="background:linear-gradient(135deg,#30cfd0,#330867)"><i class="fas fa-calendar-alt"></i></div>
        <div><div class="fs-4 fw-bold">${totalLeaves}</div><div class="text-muted small">Total Leaves</div></div>
      </div>
    </div>
  </div>

  <!-- Pending Leave Requests -->
  <div class="card border-0 shadow-sm">
    <div class="card-header bg-white d-flex justify-content-between align-items-center">
      <h6 class="mb-0"><i class="fas fa-bell me-2 text-warning"></i>Pending Leave Requests</h6>
      <a href="/admin/leaves" class="btn btn-sm btn-outline-primary">View All</a>
    </div>
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead class="table-light"><tr><th>Employee</th><th>Type</th><th>From</th><th>To</th><th>Days</th><th>Reason</th><th>Actions</th></tr></thead>
          <tbody>
            <c:forEach items="${pendingRequests}" var="lr">
            <tr>
              <td><strong>${lr.employee.fullName}</strong><br><small class="text-muted">${lr.employee.position}</small></td>
              <td><span class="badge bg-info">${lr.leaveType}</span></td>
              <td>${lr.startDate}</td>
              <td>${lr.endDate}</td>
              <td>${lr.totalDays}</td>
              <td>${lr.reason}</td>
              <td>
                <form action="/admin/leaves/${lr.id}/approve" method="post" class="d-inline">
                  <button class="btn btn-sm btn-success"><i class="fas fa-check"></i> Approve</button>
                </form>
                <form action="/admin/leaves/${lr.id}/reject" method="post" class="d-inline ms-1">
                  <input name="comments" class="form-control form-control-sm d-inline" style="width:120px" placeholder="Reason">
                  <button class="btn btn-sm btn-danger"><i class="fas fa-times"></i> Reject</button>
                </form>
              </td>
            </tr>
            </c:forEach>
            <c:if test="${empty pendingRequests}">
              <tr><td colspan="7" class="text-center py-4 text-muted"><i class="fas fa-check-circle me-2 text-success"></i>No pending requests</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
