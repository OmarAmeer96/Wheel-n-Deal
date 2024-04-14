package com.graduationproject.configuration;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * Configuration class for Twilio settings.
 * This class loads Twilio configuration properties from application.properties file.
 */
@Configuration
@Component
@ConfigurationProperties(prefix = "twilio")
@Data
public class TwilioConfiguration {

    /** Twilio account SID. */
    private String accountSid;

    /** Twilio authentication token. */
    private String authToken;

    /** Twilio phone number. */
    private String phoneNumber;
}