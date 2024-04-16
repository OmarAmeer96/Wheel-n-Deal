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

/**
 * The main class of the GraduationProject application.
 * This class serves as the entry point for running the GraduationProject application.
 * It also implements the CommandLineRunner interface to perform tasks upon application startup.
 */
@SpringBootApplication
@EnableConfigurationProperties
public class GraduationProject implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TwilioConfiguration twilioConfig;

    /**
     * The main method that starts the GraduationProject application.
     *
     * @param args Command-line arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(GraduationProject.class, args);
    }

    /**
     * This method is called upon application startup.
     * It checks if an admin account exists in the database.
     * If not, it creates one.
     *
     * @param args Command-line arguments
     * @throws Exception Exception thrown if there's an error during execution
     */
    @Override
    public void run(String... args) throws Exception {
        User adminAccount = userRepository.findByRole(Role.ADMIN);
        if (adminAccount == null) {
            User user = new User();
            user.setUsername("admin#");
            user.setPhoneNumber("admin");
            user.setRole(Role.ADMIN);
            user.setPassword(new BCryptPasswordEncoder().encode("admin"));
            userRepository.save(user);
        }
    }

    /**
     * A method annotated with @PostConstruct to perform initialization tasks after bean creation.
     * It initializes Twilio using the TwilioConfiguration properties.
     */
    @PostConstruct
    public void setup() {
        Twilio.init(twilioConfig.getAccountSid(), twilioConfig.getAuthToken());
    }
}