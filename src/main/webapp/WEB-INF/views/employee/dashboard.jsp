<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>My Dashboard - LAMS</title>
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
    .stat-card{background:#fff;border-radius:12px;padding:22px;box-shadow:0 2px 8px rgba(0,0,0,.07);}
    .avatar{width:54px;height:54px;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);color:#fff;display:flex;align-items:center;justify-content:center;font-size:1.5rem;font-weight:700;}
  </style>
</head><body>
<div class="sidebar">
  <div class="brand"><i class="fas fa-user-circle me-2"></i>Employee</div>
  <a href="/employee/dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a>
  <a href="/employee/profile"><i class="fas fa-id-card"></i> My Profile</a>
  <a href="/employee/leaves"><i class="fas fa-calendar-alt"></i> My Leaves</a>
  <a href="/employee/leaves/apply"><i class="fas fa-paper-plane"></i> Apply Leave</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

  <!-- Welcome Header -->
  <div class="d-flex align-items-center gap-3 mb-4">
    <div class="avatar">${employee.firstName.substring(0,1)}</div>
    <div>
      <h4 class="mb-0">Hello, ${employee.firstName}!</h4>
      <small class="text-muted">${employee.position} &bull; ${employee.department.name}</small>
    </div>
  </div>

  <!-- Stats -->
  <div class="row g-3 mb-4">
    <div class="col-md-4">
      <div class="stat-card text-center">
        <div class="fs-2 fw-bold text-warning">${pendingLeaves}</div>
        <div class="text-muted small mt-1">Pending Requests</div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="stat-card text-center">
        <div class="fs-2 fw-bold text-success">${approvedLeaves}</div>
        <div class="text-muted small mt-1">Approved Leaves</div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="stat-card text-center">
        <div class="fs-2 fw-bold text-primary">${myLeaves.size()}</div>
        <div class="text-muted small mt-1">Total Requests</div>
      </div>
    </div>
  </div>

  <!-- Quick Actions -->
  <div class="row g-3 mb-4">
    <div class="col-md-6">
      <div class="card border-0 shadow-sm h-100">
        <div class="card-body text-center p-4">
          <i class="fas fa-sign-in-alt fa-2x text-success mb-3"></i>
          <h6>Check In</h6>
          <p class="text-muted small">Mark your attendance for today</p>
          <form action="/employee/checkin" method="post">
            <button class="btn btn-success px-4">Check In Now</button>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card border-0 shadow-sm h-100">
        <div class="card-body text-center p-4">
          <i class="fas fa-sign-out-alt fa-2x text-danger mb-3"></i>
          <h6>Check Out</h6>
          <p class="text-muted small">Mark your end of day</p>
          <form action="/employee/checkout" method="post">
            <button class="btn btn-danger px-4">Check Out Now</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Recent Leave Requests -->
  <div class="card border-0 shadow-sm">
    <div class="card-header bg-white d-flex justify-content-between align-items-center">
      <h6 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>My Recent Leave Requests</h6>
      <a href="/employee/leaves/apply" class="btn btn-sm btn-primary">+ Apply Leave</a>
    </div>
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>Type</th><th>From</th><th>To</th><th>Days</th><th>Status</th><th>Admin Comments</th></tr></thead>
        <tbody>
          <c:forEach items="${myLeaves}" var="lr" begin="0" end="4">
          <tr>
            <td>${lr.leaveType}</td>
            <td>${lr.startDate}</td>
            <td>${lr.endDate}</td>
            <td>${lr.totalDays}</td>
            <td>
              <c:choose>
                <c:when test="${lr.status == 'PENDING'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                <c:when test="${lr.status == 'APPROVED'}"><span class="badge bg-success">Approved</span></c:when>
                <c:when test="${lr.status == 'REJECTED'}"><span class="badge bg-danger">Rejected</span></c:when>
              </c:choose>
            </td>
            <td><small class="text-muted">${lr.adminComments}</small></td>
          </tr>
          </c:forEach>
          <c:if test="${empty myLeaves}">
            <tr><td colspan="6" class="text-center py-4 text-muted">No leave requests yet. <a href="/employee/leaves/apply">Apply now</a></td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
