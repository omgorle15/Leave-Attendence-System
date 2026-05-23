package in.project.Repository;
import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.project.entities.Employee;
import in.project.entities.LeaveRequest;

@Repository
public interface LeaveRequestRepository extends JpaRepository<LeaveRequest, Long> {
    List<LeaveRequest> findByEmployee(Employee employee);
    List<LeaveRequest> findByStatus(String status);
    List<LeaveRequest> findByEmployeeAndStatus(Employee employee, String status);
    
    @Query("SELECT l FROM LeaveRequest l WHERE l.status = 'PENDING' ORDER BY l.requestDate DESC")
    List<LeaveRequest> findPendingLeaveRequests();
    
    @Query("SELECT l FROM LeaveRequest l WHERE l.employee.id = :empId AND l.startDate BETWEEN :startDate AND :endDate")
    List<LeaveRequest> findLeaveRequestsByDateRange(@Param("empId") Long empId, 
                                                     @Param("startDate") LocalDate startDate, 
                                                     @Param("endDate") LocalDate endDate);
}