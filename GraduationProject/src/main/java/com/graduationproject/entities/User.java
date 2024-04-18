package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Collection;
import java.util.List;

@Data
@Entity
@Table(name="app_user")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull
    @NotBlank
    @Column(unique=true,length = 13)
    @Pattern(regexp = "^(\\+20)?01[0-2]{1}[0-9]{8}$", message = "Invalid Egyptian phone number")
    private String phoneNumber;

    @NotBlank
    @Column(unique=true)
    @Size(min = 3, max = 100, message = "Username must be between 3 and 100 characters long")
    @Pattern(regexp = "^[a-zA-Z0-9_]+$", message = "Invalid username format. Only alphanumeric characters and underscore are allowed.")
    private String username;

    @NotNull
    @NotBlank
    @Column(unique=true)
    @Pattern(regexp = "^cus_[a-zA-Z0-9]+$", message = "Invalid Stripe ID format")
    private String stripeId;

    @Min(value = -100, message = "Minimum value for the attribute is -100")
    private Long amount;

    @NotBlank
    private String fullName;

    @Enumerated(EnumType.STRING)
    private Gender gender;

    @NotBlank
    @Size(max = 100, message = "City name must be at most 100 characters long")
    private String city;

    @NotBlank
    private String profilePictureUrl;

    @NotBlank
    @Column(length = 14)
    @Pattern(regexp = "^\\d{14}$", message = "Invalid Egyptian national ID")
    private String nationalId;

    @NotNull
    @NotBlank
    @Size(min = 6, message = "Password must be more than or equal 6 characters long")
    private String password;

    @Min(value = 0, message = "Minimum value for Total Delivers is 0")
    private Integer totalDelivers;

    @Min(value = 0, message = "Minimum value for Cancel Delivers is 0")
    private Integer cancelDelivers;

    @NotNull
    @Enumerated(EnumType.STRING)
    private Role role;

    @OneToMany(mappedBy = "user",cascade = CascadeType.REMOVE)
    private List<Token> tokens;

    @OneToMany(mappedBy = "user",cascade = CascadeType.REMOVE)
    private List<Order> orders;

    @OneToMany(mappedBy = "reviewer", cascade = CascadeType.REMOVE)
    private List<Review> givenReviews;

    @OneToMany(mappedBy = "reviewee", cascade = CascadeType.REMOVE)
    private List<Review> receivedReviews;

    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "user",cascade = CascadeType.REMOVE)
    private List<Trip> userTrips;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}