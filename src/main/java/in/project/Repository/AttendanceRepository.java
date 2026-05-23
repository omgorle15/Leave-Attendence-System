package in.project.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.project.entities.Attendance;
import in.project.entities.Employee;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    Optional<Attendance> findByEmployeeAndDate(Employee employee, LocalDate date);
    List<Attendance> findByEmployee(Employee employee);
    List<Attendance> findByEmployeeAndDateBetween(Employee employee, LocalDate startDate, LocalDate endDate);
    List<Attendance> findByDate(LocalDate date);
    
    @Query("SELECT a FROM Attendance a WHERE a.date = :date")
    List<Attendance> findTodayAttendance(@Param("date") LocalDate date);
    
    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.employee.id = :empId AND a.date BETWEEN :startDate AND :endDate AND a.status = 'PRESENT'")
    Long countPresentDays(@Param("empId") Long empId, 
                         @Param("startDate") LocalDate startDate, 
                         @Param("endDate") LocalDate endDate);
}