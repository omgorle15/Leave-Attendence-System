<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html><head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Apply Leave - LAMS</title>
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
  <a href="/employee/leaves"><i class="fas fa-calendar-alt"></i> My Leaves</a>
  <a href="/employee/leaves/apply" class="active"><i class="fas fa-paper-plane"></i> Apply Leave</a>
  <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>
<div class="main">
  <div class="d-flex align-items-center mb-4">
    <a href="/employee/leaves" class="btn btn-outline-secondary me-3"><i class="fas fa-arrow-left"></i></a>
    <h4 class="mb-0">Apply for Leave</h4>
  </div>
  <div class="card border-0 shadow-sm" style="max-width:600px">
    <div class="card-body p-4">
      <form action="/employee/leaves/apply" method="post">
        <div class="mb-3">
          <label class="form-label">Leave Type *</label>
          <select class="form-select" name="leaveType" required>
            <option value="">-- Select --</option>
            <option value="ANNUAL">Annual Leave</option>
            <option value="SICK">Sick Leave</option>
            <option value="CASUAL">Casual Leave</option>
            <option value="UNPAID">Unpaid Leave</option>
          </select>
        </div>
        <div class="row g-3 mb-3">
          <div class="col-6">
            <label class="form-label">Start Date *</label>
            <input type="date" class="form-control" name="startDate" id="startDate" required>
          </div>
          <div class="col-6">
            <label class="form-label">End Date *</label>
            <input type="date" class="form-control" name="endDate" id="endDate" required>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label">Total Days</label>
          <input type="text" class="form-control" id="totalDays" readonly placeholder="Auto calculated">
        </div>
        <div class="mb-3">
          <label class="form-label">Reason *</label>
          <textarea class="form-control" name="reason" rows="4" required placeholder="Describe your reason..."></textarea>
        </div>
        <button type="submit" class="btn btn-primary px-4"><i class="fas fa-paper-plane me-1"></i>Submit Request</button>
        <a href="/employee/leaves" class="btn btn-outline-secondary ms-2">Cancel</a>
      </form>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const s = document.getElementById('startDate');
  const e = document.getElementById('endDate');
  function calcDays(){
    if(s.value && e.value){
      const d = Math.ceil((new Date(e.value)-new Date(s.value))/(86400000))+1;
      document.getElementById('totalDays').value = d > 0 ? d+' day(s)' : 'Invalid range';
    }
  }
  s.addEventListener('change',calcDays);
  e.addEventListener('change',calcDays);
</script>
</body></html>
