package com.graduationproject;

import com.graduationproject.configuration.TwilioConfiguration;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.twilio.Twilio;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

//http://localhost:2000/swagger-ui.html

@SpringBootApplication
@EnableConfigurationProperties
@OpenAPIDefinition(info = @Info(title = "Wheel n' Deal", version = "1.0", description = "testing level"))
public class GraduationProject implements CommandLineRunner {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private TwilioConfiguration twilioConfig;

	public static void main(String[] args) {
		SpringApplication.run(GraduationProject.class, args);
	}
	@Override
	public void run(String... args) throws Exception {
		User adminAccount = userRepository.findByRole(Role.ADMIN);
		if (adminAccount == null) {
			User user = new User();
			user.setUsername("admin#");
			user.setPhoneNumber("admin");
			user.setRole(Role.ADMIN);
			user.setPassword(new BCryptPasswordEncoder().encode("admin"));
			user.setAmount((long)0);
			userRepository.save(user);
		}
	}
	@PostConstruct
	public void setup() {
		Twilio.init(twilioConfig.getAccountSid(), twilioConfig.getAuthToken());
	}
}