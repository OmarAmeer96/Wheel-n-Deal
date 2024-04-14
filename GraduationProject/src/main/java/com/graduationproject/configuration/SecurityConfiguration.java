package com.graduationproject.configuration;

import com.graduationproject.entities.Role;
import com.graduationproject.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;

/**
 * Configuration class for defining security settings.
 * This class enables web security and defines security filter chains.
 */
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfiguration {

    private final JWTAuthenticationFilter jwtAuthenticationFilter;
    private final UserService userService;
    private final LogoutHandler logoutHandler;

    /**
     * Configures security filter chain for HTTP requests.
     * @param http HttpSecurity object for configuring security settings
     * @return SecurityFilterChain object representing the configured security filter chain
     * @throws Exception If an error occurs during configuration
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(request -> request
                        .requestMatchers("/api/v1/auth/**").permitAll()
                        .requestMatchers("/api/v1/admin").hasAnyAuthority(Role.ADMIN.name())
                        .requestMatchers("/api/v1/user").hasAnyAuthority(Role.USER.name())
                        .requestMatchers("/api/v1/commuter").hasAnyAuthority(Role.COMMUTER.name())
                        .anyRequest().authenticated())
                .sessionManagement(manager -> manager.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authenticationProvider(authenticationProvider())
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .logout()
                .logoutUrl("/api/v1/auth/logout")
                .addLogoutHandler(logoutHandler)
                .logoutSuccessHandler((request, response, authentication) ->
                        SecurityContextHolder.clearContext());

        return http.build();
    }

    /**
     * Configures authentication provider.
     * @return AuthenticationProvider object representing the configured authentication provider
     */
    @Bean
    public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userService.userDetailsService());
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }

    /**
     * Configures password encoder.
     * @return PasswordEncoder object representing the configured password encoder
     */
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    /**
     * Configures authentication manager.
     * @param config AuthenticationConfiguration object for retrieving authentication manager
     * @return AuthenticationManager object representing the configured authentication manager
     * @throws Exception If an error occurs during configuration
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}