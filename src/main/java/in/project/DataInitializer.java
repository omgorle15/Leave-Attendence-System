package in.project;

import in.project.Repository.UserRepository;
import in.project.entities.Department;
import in.project.entities.User;
import in.project.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired private UserRepository userRepository;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private EmployeeService employeeService;

    @Override
    public void run(String... args) {
        // Seed admin user
        if (!userRepository.existsByUsername("admin")) {
            User admin = new User("admin",
                passwordEncoder.encode("admin123"),
                "admin@company.com", "ROLE_ADMIN");
            userRepository.save(admin);
            System.out.println("[DataInitializer] Admin user created: admin / admin123");
        } else {
            // Fix password if hash is wrong
            userRepository.findByUsername("admin").ifPresent(u -> {
                if (!passwordEncoder.matches("admin123", u.getPassword())) {
                    u.setPassword(passwordEncoder.encode("admin123"));
                    userRepository.save(u);
                    System.out.println("[DataInitializer] Admin password re-encoded.");
                }
            });
        }

        // Seed departments
        if (employeeService.getAllDepartments().isEmpty()) {
            employeeService.saveDepartment(new Department("Engineering",   "Tech team",    "Floor 3"));
            employeeService.saveDepartment(new Department("Human Resources","HR team",     "Floor 2"));
            employeeService.saveDepartment(new Department("Sales",         "Sales team",   "Floor 1"));
            employeeService.saveDepartment(new Department("Finance",       "Finance team", "Floor 2"));
            System.out.println("[DataInitializer] Default departments created.");
        }
    }
}
