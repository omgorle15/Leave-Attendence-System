package in.project.service;
 
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
 
import in.project.Repository.AttendanceRepository;
import in.project.entities.Attendance;
import in.project.entities.Employee;
 
@Service
public class AttendanceService {
 
    @Autowired
    private AttendanceRepository attendanceRepository;
 
    public List<Attendance> getAllAttendances() {
        return attendanceRepository.findAll();
    }
 
    public Attendance getAttendanceById(Long id) {
        return attendanceRepository.findById(id).orElse(null);
    }
 
    public Attendance markCheckIn(Employee employee) {
        LocalDate today = LocalDate.now();
        Attendance attendance = attendanceRepository.findByEmployeeAndDate(employee, today)
            .orElse(new Attendance());
 
        if (attendance.getId() == null) {
            attendance.setEmployee(employee);
            attendance.setDate(today);
        }
 
        attendance.setCheckInTime(LocalTime.now());
        attendance.setStatus(
            attendance.getCheckInTime().isAfter(LocalTime.of(9, 30)) ? "LATE" : "PRESENT"
        );
 
        return attendanceRepository.save(attendance);
    }
 
    public Attendance markCheckOut(Employee employee) {
        LocalDate today = LocalDate.now();
        Attendance attendance = attendanceRepository.findByEmployeeAndDate(employee, today)
            .orElse(null);
 
        if (attendance != null) {
            attendance.setCheckOutTime(LocalTime.now());
            // FIX: Recalculate working hours here (entity @PrePersist doesn't fire on updates)
            if (attendance.getCheckInTime() != null) {
                long minutes = java.time.Duration.between(
                    attendance.getCheckInTime(), attendance.getCheckOutTime()).toMinutes();
                double hours = minutes / 60.0;
                attendance.setWorkingHours(hours);
                if (hours > 9) {
                    attendance.setIsOvertime(true);
                    attendance.setOvertimeHours(hours - 9);
                }
            }
            return attendanceRepository.save(attendance);
        }
        return null;
    }
 
    // FIX: New method needed by AttendanceController.saveAttendance (was missing)
    public Attendance markManualAttendance(Employee employee, String status, String remarks) {
        LocalDate today = LocalDate.now();
        Attendance attendance = attendanceRepository.findByEmployeeAndDate(employee, today)
            .orElse(new Attendance());
 
        if (attendance.getId() == null) {
            attendance.setEmployee(employee);
            attendance.setDate(today);
        }
        attendance.setStatus(status);
        if (remarks != null) attendance.setRemarks(remarks);
        return attendanceRepository.save(attendance);
    }
 
    public List<Attendance> getAttendanceByEmployee(Employee employee) {
        return attendanceRepository.findByEmployee(employee);
    }
 
    public List<Attendance> getAttendanceByDateRange(Employee employee, LocalDate startDate, LocalDate endDate) {
        return attendanceRepository.findByEmployeeAndDateBetween(employee, startDate, endDate);
    }
 
    public List<Attendance> getTodayAttendance() {
        return attendanceRepository.findTodayAttendance(LocalDate.now());
    }
 
    public long getPresentCountToday() {
        return attendanceRepository.findTodayAttendance(LocalDate.now()).stream()
            .filter(a -> "PRESENT".equals(a.getStatus()) || "LATE".equals(a.getStatus()))
            .count();
    }
}
