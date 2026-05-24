<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>${employee.id == null ? 'Add' : 'Edit'} Employee - LAMS</title>
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
    <a href="/admin/attendance"><i class="fas fa-clipboard-list"></i> Attendance</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <div class="d-flex align-items-center mb-4">
    <a href="/admin/employees" class="btn btn-outline-secondary me-3"><i class="fas fa-arrow-left"></i></a>
    <h4 class="mb-0">${employee.id == null ? 'Add New Employee' : 'Edit Employee'}</h4>
  </div>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-4">
      <form action="${employee.id == null ? '/admin/employees/save' : '/admin/employees/update/'.concat(employee.id)}" method="post">
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">First Name *</label>
            <input type="text" class="form-control" name="firstName" value="${employee.firstName}" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Last Name *</label>
            <input type="text" class="form-control" name="lastName" value="${employee.lastName}" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Email * <small class="text-muted">(used as username)</small></label>
            <input type="email" class="form-control" name="email" value="${employee.email}" required>
          </div>
          <div class="col-md-6">
            <label class="form-label">Phone</label>
            <input type="text" class="form-control" name="phone" value="${employee.phone}">
          </div>
          <div class="col-md-6">
            <label class="form-label">Position</label>
            <input type="text" class="form-control" name="position" value="${employee.position}">
          </div>
          <div class="col-md-6">
            <label class="form-label">Department</label>
            <select class="form-select" name="departmentId">
              <option value="">-- Select --</option>
              <c:forEach items="${departments}" var="d">
                <option value="${d.id}" ${employee.department != null && employee.department.id == d.id ? 'selected' : ''}>${d.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label">Hire Date</label>
            <input type="date" class="form-control" name="hireDate" value="${employee.hireDate}">
          </div>
          <div class="col-md-6">
            <label class="form-label">Salary</label>
            <input type="number" step="0.01" class="form-control" name="salary" value="${employee.salary}">
          </div>
          <c:if test="${employee.id == null}">
          <div class="col-md-6">
            <label class="form-label">Password * <small class="text-muted">(employee login password)</small></label>
            <input type="password" class="form-control" name="password" required>
          </div>
          </c:if>
          <div class="col-12 mt-2">
            <button type="submit" class="btn btn-primary px-4"><i class="fas fa-save me-1"></i>${employee.id == null ? 'Create Employee' : 'Update Employee'}</button>
            <a href="/admin/employees" class="btn btn-outline-secondary ms-2">Cancel</a>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
