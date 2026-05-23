<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>All Leave Requests - LAMS</title>
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
  <a href="/admin/employees"><i class="fas fa-users"></i> Employees</a>
  <a href="/admin/leaves" class="active"><i class="fas fa-calendar-check"></i> Leave Requests</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <h4 class="mb-4">All Leave Requests</h4>
  <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-0">
      <table class="table table-hover mb-0">
        <thead class="table-light"><tr><th>Employee</th><th>Type</th><th>From</th><th>To</th><th>Days</th><th>Reason</th><th>Status</th><th>Actions</th></tr></thead>
        <tbody>
          <c:forEach items="${leaves}" var="lr">
          <tr>
            <td>${lr.employee.fullName}</td>
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
            <td>
              <c:if test="${lr.status == 'PENDING'}">
                <form action="/admin/leaves/${lr.id}/approve" method="post" class="d-inline">
                  <button class="btn btn-sm btn-success">Approve</button>
                </form>
                <form action="/admin/leaves/${lr.id}/reject" method="post" class="d-inline ms-1">
                  <button class="btn btn-sm btn-danger">Reject</button>
                </form>
              </c:if>
              <c:if test="${lr.status != 'PENDING'}"><span class="text-muted">—</span></c:if>
            </td>
          </tr>
          </c:forEach>
          <c:if test="${empty leaves}">
            <tr><td colspan="8" class="text-center py-4 text-muted">No leave requests found.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
