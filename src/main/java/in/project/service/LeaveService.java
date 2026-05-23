package in.project.service;
 
import java.time.LocalDateTime;
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
 
import in.project.Repository.LeaveRequestRepository;
import in.project.entities.Employee;
import in.project.entities.LeaveRequest;
 
@Service
public class LeaveService {
 
    @Autowired
    private LeaveRequestRepository leaveRequestRepository;
 
    public List<LeaveRequest> getAllLeaveRequests() {
        return leaveRequestRepository.findAll();
    }
 
    public LeaveRequest getLeaveRequestById(Long id) {
        return leaveRequestRepository.findById(id).orElse(null);
    }
 
    // Used for NEW leave requests only — sets status to PENDING
    public LeaveRequest saveLeaveRequest(LeaveRequest leaveRequest) {
        leaveRequest.setStatus("PENDING");
        return leaveRequestRepository.save(leaveRequest);
    }
 
    // FIX: Separate update method that does NOT reset status to PENDING
    // Previously saveLeaveRequest was called for both new and edits, overwriting admin decisions
    public LeaveRequest updateLeaveRequest(LeaveRequest leaveRequest) {
        return leaveRequestRepository.save(leaveRequest);
    }
 
    public LeaveRequest updateLeaveRequestStatus(Long id, String status, String comments) {
        LeaveRequest leaveRequest = getLeaveRequestById(id);
        if (leaveRequest != null) {
            leaveRequest.setStatus(status);
            leaveRequest.setAdminComments(comments);
            if ("APPROVED".equals(status) || "REJECTED".equals(status)) {
                leaveRequest.setApprovedDate(LocalDateTime.now());
            }
            return leaveRequestRepository.save(leaveRequest);
        }
        return null;
    }
 
    public List<LeaveRequest> getLeaveRequestsByEmployee(Employee employee) {
        return leaveRequestRepository.findByEmployee(employee);
    }
 
    public List<LeaveRequest> getPendingLeaveRequests() {
        return leaveRequestRepository.findPendingLeaveRequests();
    }
 
    public void deleteLeaveRequest(Long id) {
        leaveRequestRepository.deleteById(id);
    }
 
    public long getTotalLeaveRequests() {
        return leaveRequestRepository.count();
    }
 
    public long getPendingLeaveCount() {
        return leaveRequestRepository.findByStatus("PENDING").size();
    }
}
