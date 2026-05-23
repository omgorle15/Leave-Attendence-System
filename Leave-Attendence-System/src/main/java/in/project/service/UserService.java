package in.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.project.Repository.UserRepository;
import in.project.entities.UserEntity;

@Service
public class UserService {

	@Autowired
	private UserRepository repository;
	
	public void RegisterUser(UserEntity entity) {
		repository.save(entity);
	}
	
	
}
