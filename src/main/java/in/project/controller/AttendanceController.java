package in.project.controller;
 
import java.time.LocalDate;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
 
import in.project.entities.Employee;
import in.project.service.AttendanceService;
import in.project.service.EmployeeService;
 
@Controller
@RequestMapping("/attendance")
public class AttendanceController {
 
    @Autowired
    private AttendanceService attendanceService;
 
    @Autowired
    private EmployeeService employeeService;
 
    @GetMapping
    public String viewAttendance(Model model, Authentication auth) {
        if (auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            model.addAttribute("attendances", attendanceService.getTodayAttendance());
            model.addAttribute("isAdmin", true);
        } else {
            Employee employee = getEmployeeFromAuth(auth);
            if (employee != null) {
                model.addAttribute("attendances", attendanceService.getAttendanceByEmployee(employee));
            }
            model.addAttribute("isAdmin", false);
        }
        return "attendence-list";
    }
 
    @GetMapping("/checkin")
    public String checkIn(Authentication auth) {
        Employee employee = getEmployeeFromAuth(auth);
        if (employee != null) {
            attendanceService.markCheckIn(employee);
        }
        return "redirect:/dashboard";
    }
 
    // FIX: Was declared as (Model auth) — wrong type, checkout never worked
    @GetMapping("/checkout")
    public String checkOut(Authentication auth) {
        Employee employee = getEmployeeFromAuth(auth);
        if (employee != null) {
            attendanceService.markCheckOut(employee);
        }
        return "redirect:/dashboard";
    }
 
    @GetMapping("/mark")
    public String markAttendance(Model model) {
        model.addAttribute("employees", employeeService.getAllEmployees());
        model.addAttribute("today", LocalDate.now());
        return "attendence-mark";
    }
 
    @PostMapping("/mark/{employeeId}")
    public String saveAttendance(@PathVariable Long employeeId,
                                 @RequestParam String status,
                                 @RequestParam(required = false) String remarks) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        if (employee != null) {
            attendanceService.markManualAttendance(employee, status, remarks);
        }
        return "redirect:/attendance";
    }
 
    private Employee getEmployeeFromAuth(Authentication auth) {
        String username = auth.getName();
        return employeeService.getAllEmployees().stream()
            .filter(e -> e.getUser() != null && e.getUser().getUsername().equals(username))
            .findFirst().orElse(null);
    }
}
 
