<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>My Leave Requests - LAMS</title>
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
  </style>
</head><body>
<div class="sidebar">
  <div class="brand"><i class="fas fa-user-circle me-2"></i>Employee</div>
  <a href="/employee/dashboard"><i class="fas fa-home"></i> Dashboard</a>
  <a href="/employee/profile"><i class="fas fa-id-card"></i> My Profile</a>
  <a href="/employee/leaves" class="active"><i class="fas fa-calendar-alt"></i> My Leaves</a>
  <a href="/employee/leaves/apply"><i class="fas fa-paper-plane"></i> Apply Leave</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h4>My Leave Requests</h4>
    <a href="/employee/leaves/apply" class="btn btn-primary"><i class="fas fa-plus me-1"></i>Apply Leave</a>
  </div>
  <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>Type</th><th>From</th><th>To</th><th>Days</th><th>Reason</th><th>Status</th><th>Admin Comments</th><th>Action</th></tr></thead>
        <tbody>
          <c:forEach items="${leaves}" var="lr">
          <tr>
            <td>${lr.leaveType}</td>
            <td>${lr.startDate}</td>
            <td>${lr.endDate}</td>
            <td>${lr.totalDays}</td>
            <td>${lr.reason}</td>
            <td>
              <c:choose>
                <c:when test="${lr.status == 'PENDING'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                <c:when test="${lr.status == 'APPROVED'}"><span class="badge bg-success">Approved</span></c:when>
                <c:when test="${lr.status == 'REJECTED'}"><span class="badge bg-danger">Rejected</span></c:when>
              </c:choose>
            </td>
            <td><small class="text-muted">${lr.adminComments}</small></td>
            <td>
              <c:if test="${lr.status == 'PENDING'}">
                <form action="/employee/leaves/${lr.id}/cancel" method="post">
                  <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Cancel this request?')">Cancel</button>
                </form>
              </c:if>
            </td>
          </tr>
          </c:forEach>
          <c:if test="${empty leaves}">
            <tr><td colspan="8" class="text-center py-4 text-muted">No leave requests yet.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
