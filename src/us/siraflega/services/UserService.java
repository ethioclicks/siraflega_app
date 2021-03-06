package us.siraflega.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import us.siraflega.entities.Employee;
import us.siraflega.entities.Employer;
import us.siraflega.entities.Role;
import us.siraflega.entities.Timesvisited;
import us.siraflega.entities.User;
import us.siraflega.repositories.RoleRepository;
import us.siraflega.repositories.TimesvisitedRepo;
import us.siraflega.repositories.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	UserRepository userRepository;

	@Autowired
	RoleRepository roleRepository;

	@Autowired
	TimesvisitedRepo timesvisitedRepo;

	@Autowired
	EmployeerService employeerService;
	@Autowired
	EmployeeService employeeService;

	public List<User> getAllUsers() {
		return userRepository.findAll();
	}

	public User getOneBy(int id) {
		// TODO Auto-generated method stub
		return userRepository.findOne(id);
	}

	public User saveUser(User user, String type) {
		User savedUser = new User();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		user.setPassword(encoder.encode(user.getPassword()));
		user.setEnabled(true);
		if (type.equals("employer")) {
			user.setRole(roleRepository.findByName("ROLE_EMPLOYER"));
			savedUser = userRepository.save(user);
			if (savedUser != null) {
				Employer employer = new Employer();
				employer.setEmail(user.getEmail());
				employeerService.saveEmployer(employer);
			}
		} else {
			// roles.add(roleRepository.findByName("ROLE_EMPLOYEE"));
			user.setRole(roleRepository.findByName("ROLE_EMPLOYEE"));
			savedUser = userRepository.save(user);
			if (savedUser != null) {
				Employee employee = new Employee();
				employee.setEmail(user.getEmail());
				employeeService.saveEmployee(employee);
			}
		}
		return savedUser;
	}

	public void removeUser(int id) {
		userRepository.delete(id);
	}

	public User getUserByName(String name) {
		return userRepository.findByUserName(name);
	}

	public void getDelete(int id) {
		userRepository.delete(id);

	}

	public User saveUser(User exisitingUser) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		exisitingUser.setPassword(encoder.encode(exisitingUser.getPassword()));
		return userRepository.save(exisitingUser);
	}

	public User saveUserWithOutPassword(User exisitingUser) {
		// TODO Auto-generated method stub
		return userRepository.save(exisitingUser);
	}

	public User getUserByEmail(String newUserEmail) {
		// TODO Auto-generated method stub
		return userRepository.findByEmail(newUserEmail);
	}

	public int getTimesvisited() {
		Timesvisited timesVisited = timesvisitedRepo.findOne(1L);
		return timesVisited.getTimesvisited();
	}

	public int updateTimevisitied() {
		Timesvisited timesVisited = timesvisitedRepo.findOne(1L);
		if (timesVisited != null) {
			int was = timesVisited.getTimesvisited();
			timesVisited.setTimesvisited(timesVisited.getTimesvisited() + 1);
			timesvisitedRepo.save(timesVisited);
			return was;
		}

		return 0;
	}

}
