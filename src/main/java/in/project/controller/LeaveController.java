package in.project.controller;
 
import java.time.LocalDate;
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
 
import in.project.entities.Employee;
import in.project.entities.LeaveRequest;
import in.project.service.EmployeeService;
import in.project.service.LeaveService;
 
@Controller
@RequestMapping("/leaves")
public class LeaveController {
 
    @Autowired
    private LeaveService leaveService;
 
    @Autowired
    private EmployeeService employeeService;
 
    @GetMapping
    public String listLeaves(Model model, Authentication auth) {
        if (isAdmin(auth)) {
            model.addAttribute("leaves", leaveService.getAllLeaveRequests());
            model.addAttribute("isAdmin", true);
        } else {
            Employee employee = getEmployeeFromAuth(auth);
            if (employee != null) {
                model.addAttribute("leaves", leaveService.getLeaveRequestsByEmployee(employee));
                model.addAttribute("employee", employee);
            }
            model.addAttribute("isAdmin", false);
        }
        return "leave-list";
    }
 
    @GetMapping("/new")
    public String showCreateForm(Model model, Authentication auth) {
        model.addAttribute("leaveRequest", new LeaveRequest());
        Employee employee = getEmployeeFromAuth(auth);
        model.addAttribute("employee", employee);
        return "leave-form";
    }
 
    @PostMapping("/save")
    public String saveLeaveRequest(@RequestParam String leaveType,
                                   @RequestParam String startDate,
                                   @RequestParam String endDate,
                                   @RequestParam String reason,
                                   Authentication auth) {
        Employee employee = getEmployeeFromAuth(auth);
        if (employee != null) {
            LeaveRequest leaveRequest = new LeaveRequest();
            leaveRequest.setEmployee(employee);
            leaveRequest.setLeaveType(leaveType);
            leaveRequest.setStartDate(LocalDate.parse(startDate));
            leaveRequest.setEndDate(LocalDate.parse(endDate));
            leaveRequest.setReason(reason);
            leaveService.saveLeaveRequest(leaveRequest);
        }
        return "redirect:/leaves";
    }
 
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, Authentication auth) {
        LeaveRequest leaveRequest = leaveService.getLeaveRequestById(id);
        if (leaveRequest == null) return "redirect:/leaves";
        model.addAttribute("leaveRequest", leaveRequest);
 
        boolean admin = isAdmin(auth);
        boolean isOwner = leaveRequest.getEmployee().getUser() != null
            && leaveRequest.getEmployee().getUser().getUsername().equals(auth.getName());
 
        model.addAttribute("canEdit", admin || isOwner);
        model.addAttribute("isAdmin", admin);
        return "leave-form";
    }
 
    @PostMapping("/update/{id}")
    public String updateLeaveRequest(@PathVariable Long id,
                                     @RequestParam(required = false) String status,
                                     @RequestParam(required = false) String adminComments,
                                     @RequestParam(required = false) String leaveType,
                                     @RequestParam(required = false) String startDate,
                                     @RequestParam(required = false) String endDate,
                                     @RequestParam(required = false) String reason) {
        if (status != null) {
            // Admin updating status
            leaveService.updateLeaveRequestStatus(id, status, adminComments != null ? adminComments : "");
        } else {
            // Employee editing their own pending request
            LeaveRequest existing = leaveService.getLeaveRequestById(id);
            if (existing != null && "PENDING".equals(existing.getStatus())) {
                if (leaveType != null) existing.setLeaveType(leaveType);
                if (startDate != null) existing.setStartDate(LocalDate.parse(startDate));
                if (endDate != null) existing.setEndDate(LocalDate.parse(endDate));
                if (reason != null) existing.setReason(reason);
                // FIX: Use updateEmployee (not saveLeaveRequest) so status isn't reset to PENDING
                leaveService.updateLeaveRequest(existing);
            }
        }
        return "redirect:/leaves";
    }
 
    // FIX: /leaves/view/{id} previously returned "leave-details" which doesn't exist
    // Redirected to leave-list which shows the leave; a proper leave-details.jsp can be added later
    @GetMapping("/view/{id}")
    public String viewLeaveDetails(@PathVariable Long id, Model model) {
        LeaveRequest leaveRequest = leaveService.getLeaveRequestById(id);
        if (leaveRequest == null) return "redirect:/leaves";
        model.addAttribute("leave", leaveRequest);
        model.addAttribute("leaves", List.of(leaveRequest));
        model.addAttribute("isAdmin", false);
        return "leave-list";
    }
 
    @GetMapping("/delete/{id}")
    public String deleteLeaveRequest(@PathVariable Long id, Authentication auth) {
        LeaveRequest leaveRequest = leaveService.getLeaveRequestById(id);
        if (leaveRequest != null) {
            boolean admin = isAdmin(auth);
            boolean isOwner = leaveRequest.getEmployee().getUser() != null
                && leaveRequest.getEmployee().getUser().getUsername().equals(auth.getName());
            if (admin || (isOwner && "PENDING".equals(leaveRequest.getStatus()))) {
                leaveService.deleteLeaveRequest(id);
            }
        }
        return "redirect:/leaves";
    }
 
    @PostMapping("/admin/{id}/approve")
    public String approveLeave(@PathVariable Long id, @RequestParam(required = false) String comments) {
        leaveService.updateLeaveRequestStatus(id, "APPROVED", comments != null ? comments : "");
        return "redirect:/admin/dashboard";
    }
 
    @PostMapping("/admin/{id}/reject")
    public String rejectLeave(@PathVariable Long id, @RequestParam(required = false) String comments) {
        leaveService.updateLeaveRequestStatus(id, "REJECTED", comments != null ? comments : "");
        return "redirect:/admin/dashboard";
    }
 
    // FIX: /leaves/calendar returned "leave-calendar" which doesn't exist — redirect to leave-list
    @GetMapping("/calendar")
    public String viewLeaveCalendar(Authentication auth) {
        return "redirect:/leaves";
    }
 
    // --- helpers ---
 
    private boolean isAdmin(Authentication auth) {
        return auth.getAuthorities().stream()
            .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    }
 
    private Employee getEmployeeFromAuth(Authentication auth) {
        String username = auth.getName();
        return employeeService.getAllEmployees().stream()
            .filter(e -> e.getUser() != null && e.getUser().getUsername().equals(username))
            .findFirst().orElse(null);
    }
}
