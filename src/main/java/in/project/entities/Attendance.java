package in.project.entities;
 
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
 
@Entity
@Table(name = "attendances")
public class Attendance {
 
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
 
    @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;
 
    @Column(nullable = false)
    private LocalDate date;
 
    private LocalTime checkInTime;
 
    private LocalTime checkOutTime;
 
    private String status; // PRESENT, ABSENT, LATE, HALF_DAY, HOLIDAY
 
    private String remarks;
 
    private Double workingHours;
 
    private Boolean isOvertime = false;
 
    private Double overtimeHours;
 
    private LocalDateTime createdAt;
 
    public Attendance() {
        this.createdAt = LocalDateTime.now();
    }
 
    // FIX: Was @PrePersist only — that fires only on INSERT (first save).
    // Checkout is an UPDATE, so workingHours was NEVER calculated.
    // Adding @PreUpdate ensures it runs on both insert and update.
    @PrePersist
    @PreUpdate
    public void calculateWorkingHours() {
        if (this.checkInTime != null && this.checkOutTime != null) {
            long minutes = java.time.Duration.between(checkInTime, checkOutTime).toMinutes();
            this.workingHours = minutes / 60.0;
            if (this.workingHours > 9) {
                this.isOvertime = true;
                this.overtimeHours = this.workingHours - 9;
            } else {
                this.isOvertime = false;
                this.overtimeHours = 0.0;
            }
        }
    }
 
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
 
    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }
 
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
 
    public LocalTime getCheckInTime() { return checkInTime; }
    public void setCheckInTime(LocalTime checkInTime) { this.checkInTime = checkInTime; }
 
    public LocalTime getCheckOutTime() { return checkOutTime; }
    public void setCheckOutTime(LocalTime checkOutTime) { this.checkOutTime = checkOutTime; }
 
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
 
    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
 
    public Double getWorkingHours() { return workingHours; }
    public void setWorkingHours(Double workingHours) { this.workingHours = workingHours; }
 
    public Boolean getIsOvertime() { return isOvertime; }
    public void setIsOvertime(Boolean isOvertime) { this.isOvertime = isOvertime; }
 
    public Double getOvertimeHours() { return overtimeHours; }
    public void setOvertimeHours(Double overtimeHours) { this.overtimeHours = overtimeHours; }
 
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
