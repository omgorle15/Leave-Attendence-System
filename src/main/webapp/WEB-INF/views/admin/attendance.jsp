<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Attendance - LAMS Admin</title>
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
    .status-badge{display:inline-block;padding:3px 10px;border-radius:20px;font-size:.78rem;font-weight:600;}
    .status-present{background:#d4edda;color:#155724;}
    .status-late{background:#fff3cd;color:#856404;}
    .status-absent{background:#f8d7da;color:#721c24;}
    .status-checkedin{background:#cce5ff;color:#004085;}
    .status-na{background:#e2e3e5;color:#383d41;}
    .time-pill{font-size:.82rem;background:#f0f0f5;border-radius:8px;padding:3px 10px;display:inline-block;}
    .checkin-time{color:#28a745;}
    .checkout-time{color:#dc3545;}
    .summary-card{background:#fff;border-radius:12px;padding:18px 22px;box-shadow:0 2px 8px rgba(0,0,0,.07);}
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <div class="brand"><i class="fas fa-building me-2"></i>LAMS Admin</div>
  <a href="/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
  <a href="/admin/employees"><i class="fas fa-users"></i> Employees</a>
  <a href="/admin/leaves"><i class="fas fa-calendar-check"></i> Leave Requests</a>
  <a href="/admin/attendance" class="active"><i class="fas fa-clipboard-list"></i> Attendance</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Main -->
<div class="main">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0"><i class="fas fa-clipboard-list me-2 text-primary"></i>Attendance</h4>
      <small class="text-muted">Today's employee check-in &amp; check-out records</small>
    </div>
    <span class="badge bg-secondary fs-6">
      <i class="fas fa-calendar-day me-1"></i>
      <%
        java.time.LocalDate today = java.time.LocalDate.now();
        java.time.format.DateTimeFormatter fmt =
            java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy");
        out.print(today.format(fmt));
      %>
    </span>
  </div>

  <!-- Summary Cards -->
  <div class="row g-3 mb-4">
    <div class="col-md-3">
      <div class="summary-card d-flex align-items-center gap-3">
        <div style="width:46px;height:46px;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
          <i class="fas fa-users"></i>
        </div>
        <div>
          <div class="fs-4 fw-bold">${employees.size()}</div>
          <div class="text-muted small">Total Employees</div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="summary-card d-flex align-items-center gap-3">
        <div style="width:46px;height:46px;border-radius:50%;background:linear-gradient(135deg,#43e97b,#38f9d7);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
          <i class="fas fa-sign-in-alt"></i>
        </div>
        <div>
          <div class="fs-4 fw-bold">${attendances.size()}</div>
          <div class="text-muted small">Checked In Today</div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="summary-card d-flex align-items-center gap-3">
        <div style="width:46px;height:46px;border-radius:50%;background:linear-gradient(135deg,#ffc107,#ff9800);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
          <i class="fas fa-clock"></i>
        </div>
        <div>
          <div class="fs-4 fw-bold">
            <c:set var="lateCount" value="0"/>
            <c:forEach items="${attendances}" var="a">
              <c:if test="${a.status == 'LATE'}">
                <c:set var="lateCount" value="${lateCount + 1}"/>
              </c:if>
            </c:forEach>
            ${lateCount}
          </div>
          <div class="text-muted small">Late Arrivals</div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="summary-card d-flex align-items-center gap-3">
        <div style="width:46px;height:46px;border-radius:50%;background:linear-gradient(135deg,#dc3545,#c0392b);display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.2rem;">
          <i class="fas fa-user-times"></i>
        </div>
        <div>
          <div class="fs-4 fw-bold">${employees.size() - attendances.size()}</div>
          <div class="text-muted small">Not Checked In</div>
        </div>
      </div>
    </div>
  </div>

  <!-- Attendance Table -->
  <div class="card border-0 shadow-sm">
    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
      <h6 class="mb-0"><i class="fas fa-list me-2 text-primary"></i>Employee Check-In / Check-Out</h6>
      <span class="text-muted small">Showing all employees for today</span>
    </div>
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-light">
            <tr>
              <th class="ps-3">Employee</th>
              <th>Department</th>
              <th>Status</th>
              <th><i class="fas fa-sign-in-alt text-success me-1"></i>Check In</th>
              <th><i class="fas fa-sign-out-alt text-danger me-1"></i>Check Out</th>
              <th>Working Hours</th>
            </tr>
          </thead>
          <tbody>
            <!-- Employees who have attendance records today -->
            <c:forEach items="${attendances}" var="a">
            <tr>
              <td class="ps-3">
                <div class="d-flex align-items-center gap-2">
                  <div style="width:36px;height:36px;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);color:#fff;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.9rem;">
                    ${a.employee.firstName.substring(0,1)}
                  </div>
                  <div>
                    <div class="fw-semibold">${a.employee.fullName}</div>
                    <small class="text-muted">${a.employee.employeeId}</small>
                  </div>
                </div>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty a.employee.department}">${a.employee.department.name}</c:when>
                  <c:otherwise><span class="text-muted">—</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${a.status == 'PRESENT'}"><span class="status-badge status-present"><i class="fas fa-check-circle me-1"></i>Present</span></c:when>
                  <c:when test="${a.status == 'LATE'}"><span class="status-badge status-late"><i class="fas fa-exclamation-circle me-1"></i>Late</span></c:when>
                  <c:when test="${a.status == 'ABSENT'}"><span class="status-badge status-absent"><i class="fas fa-times-circle me-1"></i>Absent</span></c:when>
                  <c:otherwise><span class="status-badge status-checkedin">${a.status}</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty a.checkInTime}">
                    <span class="time-pill checkin-time"><i class="fas fa-sign-in-alt me-1"></i>${a.checkInTime}</span>
                  </c:when>
                  <c:otherwise><span class="text-muted small">—</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty a.checkOutTime}">
                    <span class="time-pill checkout-time"><i class="fas fa-sign-out-alt me-1"></i>${a.checkOutTime}</span>
                  </c:when>
                  <c:otherwise>
                    <span class="text-muted small"><i class="fas fa-spinner fa-spin me-1"></i>Still working</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty a.workingHours}">
                    <span class="fw-semibold">${a.workingHours} hrs</span>
                    <c:if test="${a.isOvertime}">
                      <span class="badge bg-warning text-dark ms-1" title="Overtime">OT</span>
                    </c:if>
                  </c:when>
                  <c:otherwise><span class="text-muted small">—</span></c:otherwise>
                </c:choose>
              </td>
            </tr>
            </c:forEach>

            <!-- Employees with NO attendance record today (absent/not checked in) -->
            <c:forEach items="${employees}" var="emp">
              <c:set var="found" value="false"/>
              <c:forEach items="${attendances}" var="a">
                <c:if test="${a.employee.id == emp.id}">
                  <c:set var="found" value="true"/>
                </c:if>
              </c:forEach>
              <c:if test="${!found}">
              <tr class="table-light">
                <td class="ps-3">
                  <div class="d-flex align-items-center gap-2">
                    <div style="width:36px;height:36px;border-radius:50%;background:#dee2e6;color:#6c757d;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.9rem;">
                      ${emp.firstName.substring(0,1)}
                    </div>
                    <div>
                      <div class="fw-semibold text-muted">${emp.fullName}</div>
                      <small class="text-muted">${emp.employeeId}</small>
                    </div>
                  </div>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${not empty emp.department}">${emp.department.name}</c:when>
                    <c:otherwise><span class="text-muted">—</span></c:otherwise>
                  </c:choose>
                </td>
                <td><span class="status-badge status-na"><i class="fas fa-minus-circle me-1"></i>Not Checked In</span></td>
                <td><span class="text-muted small">—</span></td>
                <td><span class="text-muted small">—</span></td>
                <td><span class="text-muted small">—</span></td>
              </tr>
              </c:if>
            </c:forEach>

            <c:if test="${empty employees}">
              <tr><td colspan="6" class="text-center py-5 text-muted">
                <i class="fas fa-users-slash fa-2x mb-2 d-block"></i>No employees found.
              </td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
