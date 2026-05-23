package in.project.controller;

import in.project.entities.Department;
import in.project.entities.Employee;
import in.project.service.AttendanceService;
import in.project.service.EmployeeService;
import in.project.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private EmployeeService employeeService;
    @Autowired private LeaveService leaveService;
    @Autowired private AttendanceService attendanceService;

    /* ── Dashboard ── */
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalEmployees",  employeeService.getTotalEmployees());
        model.addAttribute("pendingLeaves",   leaveService.getPendingLeaveCount());
        model.addAttribute("totalLeaves",     leaveService.getTotalLeaveRequests());
        model.addAttribute("presentCount",    attendanceService.getPresentCountToday());
        model.addAttribute("pendingRequests", leaveService.getPendingLeaveRequests());
        model.addAttribute("employees",       employeeService.getAllEmployees());
        return "admin/dashboard";
    }

    /* ── Employee CRUD ── */
    @GetMapping("/employees")
    public String listEmployees(Model model) {
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "admin/employee-list";
    }

    @GetMapping("/employees/new")
    public String newEmployee(Model model) {
        model.addAttribute("employee",    new Employee());
        model.addAttribute("departments", employeeService.getAllDepartments());
        return "admin/employee-form";
    }

    @PostMapping("/employees/save")
    public String saveEmployee(@ModelAttribute Employee employee,
                               @RequestParam String password,
                               @RequestParam(required = false) Long departmentId,
                               RedirectAttributes ra) {
        if (departmentId != null) {
            Department dept = employeeService.getDepartmentById(departmentId);
            employee.setDepartment(dept);
        }
        employeeService.saveEmployee(employee, password);
        ra.addFlashAttribute("success", "Employee created successfully!");
        return "redirect:/admin/employees";
    }

    @GetMapping("/employees/edit/{id}")
    public String editEmployee(@PathVariable Long id, Model model) {
        model.addAttribute("employee",    employeeService.getEmployeeById(id));
        model.addAttribute("departments", employeeService.getAllDepartments());
        return "admin/employee-form";
    }

    @PostMapping("/employees/update/{id}")
    public String updateEmployee(@PathVariable Long id,
                                 @ModelAttribute Employee employee,
                                 @RequestParam(required = false) Long departmentId,
                                 RedirectAttributes ra) {
        Employee existing = employeeService.getEmployeeById(id);
        employee.setId(id);
        employee.setUser(existing.getUser());
        employee.setEmployeeId(existing.getEmployeeId());
        if (departmentId != null) {
            employee.setDepartment(employeeService.getDepartmentById(departmentId));
        }
        employeeService.updateEmployee(employee);
        ra.addFlashAttribute("success", "Employee updated successfully!");
        return "redirect:/admin/employees";
    }

    @GetMapping("/employees/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, RedirectAttributes ra) {
        employeeService.deleteEmployee(id);
        ra.addFlashAttribute("success", "Employee deleted.");
        return "redirect:/admin/employees";
    }

    /* ── Leave Management ── */
    @GetMapping("/leaves")
    public String allLeaves(Model model) {
        model.addAttribute("leaves",   leaveService.getAllLeaveRequests());
        model.addAttribute("isAdmin",  true);
        return "admin/leave-list";
    }

    @PostMapping("/leaves/{id}/approve")
    public String approveLeave(@PathVariable Long id,
                                @RequestParam(required = false) String comments,
                                RedirectAttributes ra) {
        leaveService.updateLeaveRequestStatus(id, "APPROVED", comments != null ? comments : "");
        ra.addFlashAttribute("success", "Leave approved.");
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/leaves/{id}/reject")
    public String rejectLeave(@PathVariable Long id,
                               @RequestParam(required = false) String comments,
                               RedirectAttributes ra) {
        leaveService.updateLeaveRequestStatus(id, "REJECTED", comments != null ? comments : "");
        ra.addFlashAttribute("success", "Leave rejected.");
        return "redirect:/admin/dashboard";
    }
}
