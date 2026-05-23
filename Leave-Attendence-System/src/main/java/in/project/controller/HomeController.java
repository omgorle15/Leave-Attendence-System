package in.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import in.project.entities.UserEntity;
import in.project.service.UserService;
import jakarta.annotation.PostConstruct;

@Controller
public class HomeController {

	@Autowired
	private UserService service;
	@GetMapping("/")
	public String Home() {
		
		return "index";
	}
	
	@GetMapping("/SignUp")
	public String showSignup() {
	    return "SignUp";
	}

	@PostMapping("/SignUp")
	public String SignUp(@ModelAttribute UserEntity user) {

	    service.RegisterUser(user);

	    return "SignIn";
	}
	
	@GetMapping("/SignIn")
	public String showSignIn() {
		return "SignIn";
	}
	
	@PostMapping()
	
	
}
