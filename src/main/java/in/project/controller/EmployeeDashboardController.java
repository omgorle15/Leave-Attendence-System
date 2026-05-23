package in.project.controller;

import in.project.entities.Employee;
import in.project.entities.LeaveRequest;
import in.project.service.AttendanceService;
import in.project.service.EmployeeService;
import in.project.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/employee")
public class EmployeeDashboardController {

    @Autowired private EmployeeService employeeService;
    @Autowired private LeaveService leaveService;
    @Autowired private AttendanceService attendanceService;

    private Employee getEmployee(Authentication auth) {
        return employeeService.getAllEmployees().stream()
            .filter(e -> e.getUser() != null && e.getUser().getUsername().equals(auth.getName()))
            .findFirst().orElse(null);
    }

    /* ── Dashboard ── */
    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {
        Employee emp = getEmployee(auth);
        if (emp == null) return "redirect:/login?logout";
        model.addAttribute("employee",      emp);
        model.addAttribute("myLeaves",      leaveService.getLeaveRequestsByEmployee(emp));
        model.addAttribute("pendingLeaves", leaveService.getLeaveRequestsByEmployee(emp)
            .stream().filter(l -> "PENDING".equals(l.getStatus())).count());
        model.addAttribute("approvedLeaves", leaveService.getLeaveRequestsByEmployee(emp)
            .stream().filter(l -> "APPROVED".equals(l.getStatus())).count());
        model.addAttribute("myAttendance",  attendanceService.getAttendanceByEmployee(emp));
        return "employee/dashboard";
    }

    /* ── Profile ── */
    @GetMapping("/profile")
    public String profile(Model model, Authentication auth) {
        Employee emp = getEmployee(auth);
        if (emp == null) return "redirect:/login?logout";
        model.addAttribute("employee", emp);
        return "employee/profile";
    }

    /* ── Leave: list ── */
    @GetMapping("/leaves")
    public String myLeaves(Model model, Authentication auth) {
        Employee emp = getEmployee(auth);
        if (emp == null) return "redirect:/login?logout";
        model.addAttribute("employee", emp);
        model.addAttribute("leaves",   leaveService.getLeaveRequestsByEmployee(emp));
        return "employee/leave-list";
    }

    /* ── Leave: apply form ── */
    @GetMapping("/leaves/apply")
    public String applyLeaveForm(Model model, Authentication auth) {
        Employee emp = getEmployee(auth);
        if (emp == null) return "redirect:/login?logout";
        model.addAttribute("employee", emp);
        return "employee/leave-form";
    }

    /* ── Leave: submit ── */
    @PostMapping("/leaves/apply")
    public String submitLeave(@RequestParam String leaveType,
                              @RequestParam String startDate,
                              @RequestParam String endDate,
                              @RequestParam String reason,
                              Authentication auth,
                              RedirectAttributes ra) {
        Employee emp = getEmployee(auth);
        if (emp == null) return "redirect:/login?logout";

        LeaveRequest lr = new LeaveRequest();
        lr.setEmployee(emp);
        lr.setLeaveType(leaveType);
        lr.setStartDate(LocalDate.parse(startDate));
        lr.setEndDate(LocalDate.parse(endDate));
        lr.setReason(reason);
        leaveService.saveLeaveRequest(lr);

        ra.addFlashAttribute("success", "Leave request submitted successfully!");
        return "redirect:/employee/leaves";
    }

    /* ── Leave: cancel (only PENDING) ── */
    @PostMapping("/leaves/{id}/cancel")
    public String cancelLeave(@PathVariable Long id, Authentication auth, RedirectAttributes ra) {
        LeaveRequest lr = leaveService.getLeaveRequestById(id);
        Employee emp = getEmployee(auth);
        if (lr != null && emp != null
                && lr.getEmployee().getId().equals(emp.getId())
                && "PENDING".equals(lr.getStatus())) {
            leaveService.deleteLeaveRequest(id);
            ra.addFlashAttribute("success", "Leave request cancelled.");
        }
        return "redirect:/employee/leaves";
    }

    /* ── Check In / Out ── */
    @PostMapping("/checkin")
    public String checkIn(Authentication auth, RedirectAttributes ra) {
        Employee emp = getEmployee(auth);
        if (emp != null) {
            attendanceService.markCheckIn(emp);
            ra.addFlashAttribute("success", "Checked in successfully!");
        }
        return "redirect:/employee/dashboard";
    }

    @PostMapping("/checkout")
    public String checkOut(Authentication auth, RedirectAttributes ra) {
        Employee emp = getEmployee(auth);
        if (emp != null) {
            attendanceService.markCheckOut(emp);
            ra.addFlashAttribute("success", "Checked out successfully!");
        }
        return "redirect:/employee/dashboard";
    }
}
