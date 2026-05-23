package in.project.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import in.project.entities.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {

}
