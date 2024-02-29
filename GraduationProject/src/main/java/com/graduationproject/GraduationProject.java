package com.graduationproject;

import com.graduationproject.configuration.TwilioConfiguration;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.UserRepository;
import com.twilio.Twilio;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.stripe.Stripe;


@SpringBootApplication
@EnableConfigurationProperties
public class GraduationProject implements CommandLineRunner {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private TwilioConfiguration twilioConfig;


	public static void main(String[] args) {
		SpringApplication.run(GraduationProject.class, args);
		Stripe.apiKey = "sk_test_51Of0HSDRpAtfI02p07kURFyWFuON9GhxXSEzZNxRpbVqLXc83KH0JcMjeURgkwf6UXsD9Xm7Z7sVf3g9tFC2Gdeo00fPYbS9G6";
	}


	@Override
	public void run(String... args) throws Exception {
		User adminAccount = userRepository.findByRole(Role.ADMIN);
		if(adminAccount == null){
			User user = new User();
			user.setUserName("admin#");
			user.setPhoneNumber("admin");
			user.setRole(Role.ADMIN);
			user.setPassword(new BCryptPasswordEncoder().encode("admin"));
			userRepository.save(user);
		}
	}
	@PostConstruct
	public void setup() {
		Twilio.init(twilioConfig.getAccountSid(), twilioConfig.getAuthToken());
	}

}


