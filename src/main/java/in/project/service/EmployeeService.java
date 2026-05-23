package in.project.service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import in.project.Repository.DepartmentRepository;
import in.project.Repository.EmployeeRepository;
import in.project.Repository.UserRepository;
import in.project.entities.Department;
import in.project.entities.Employee;
import in.project.entities.User;

@Service
public class EmployeeService {
    
    @Autowired
    private EmployeeRepository employeeRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private DepartmentRepository departmentRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }
    
    public Employee getEmployeeById(Long id) {
        return employeeRepository.findById(id).orElse(null);
    }
    
    public Employee getEmployeeByUser(User user) {
        return employeeRepository.findByUser(user).orElse(null);
    }
    
    public Employee saveEmployee(Employee employee, String password) {
        // Generate employee ID
        employee.setEmployeeId("EMP" + System.currentTimeMillis());
        
        // Create user account for employee
        User user = new User();
        user.setUsername(employee.getEmail());
        user.setPassword(passwordEncoder.encode(password));
        user.setEmail(employee.getEmail());
        user.setRole("ROLE_EMPLOYEE");
        user = userRepository.save(user);
        
        employee.setUser(user);
        return employeeRepository.save(employee);
    }
    
    public Employee updateEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }
    
    public void deleteEmployee(Long id) {
        Employee employee = getEmployeeById(id);
        if (employee != null && employee.getUser() != null) {
            userRepository.delete(employee.getUser());
        }
        employeeRepository.deleteById(id);
    }
    
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }
    
    public Department getDepartmentById(Long id) {
        return departmentRepository.findById(id).orElse(null);
    }
    
    public Department saveDepartment(Department department) {
        return departmentRepository.save(department);
    }
    
    public long getTotalEmployees() {
        return employeeRepository.count();
    }
}