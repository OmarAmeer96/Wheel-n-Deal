package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Collection;
import java.util.List;

/**
 * Represents a user entity in the application.
 */
@Data
@Entity
@Table(name="app_user")
public class User implements UserDetails {

    /** The unique identifier for the user. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /** The phone number of the user. */
    @NotNull
    @Column(unique=true,length = 13)
    @Pattern(regexp = "^(\\+20)?01[0-2]{1}[0-9]{8}$", message = "Invalid Egyptian phone number")
    private String phoneNumber;

    /** The username of the user. */
    @Size(min = 3, max = 100, message = "Username must be between 3 and 100 characters long")
    @Pattern(regexp = "^[a-zA-Z0-9_]+$", message = "Invalid username format. Only alphanumeric characters and underscore are allowed.")
    private String username;

    /** The ID associated with the user in the Stripe payment system. */
    @NotNull
    @Column(unique=true)
    @Pattern(regexp = "^cus_[a-zA-Z0-9]+$", message = "Invalid Stripe ID format")
    private String stripeId;

    /** The amount of money associated with the user. */
    @Min(value = -100, message = "Minimum value for the attribute is -100")
    private Long amount;

    /** The full name of the user. */
    private String fullName;

    /** The gender of the user. */
    @Enumerated(EnumType.STRING)
    private Gender gender;

    /** The city where the user resides. */
    @Size(max = 100, message = "City name must be at most 100 characters long")
    private String city;

    /** The URL of the user's profile picture. */
    private String profilePictureUrl;

    /** The national ID of the user. */
    @Column(length = 14)
    @Pattern(regexp = "^\\d{14}$", message = "Invalid Egyptian national ID")
    private String nationalId;

    /** The password of the user. */
    @NotNull
    @Size(min = 6, message = "Password must be more than or equal 6 characters long")
    private String password;

    /** The total number of deliveries made by the user. */
    @Min(value = 0, message = "Minimum value for Total Delivers is 0")
    private Integer totalDelivers;

    /** The number of deliveries cancelled by the user. */
    @Min(value = 0, message = "Minimum value for Cancel Delivers is 0")
    private Integer cancelDelivers;

    /** The role of the user in the application. */
    @NotNull
    @Enumerated(EnumType.STRING)
    private Role role;

    /** The list of tokens associated with the user. */
    @OneToMany(mappedBy = "user",cascade = CascadeType.REMOVE)
    private List<Token> tokens;

    /** The list of orders placed by the user. */
    @OneToMany(mappedBy = "user",cascade = CascadeType.REMOVE)
    private List<Order> orders;

    /** The list of reviews given by the user. */
    @OneToMany(mappedBy = "reviewer", cascade = CascadeType.REMOVE)
    private List<Review> givenReviews;

    /** The list of reviews received by the user. */
    @OneToMany(mappedBy = "reviewee", cascade = CascadeType.REMOVE)
    private List<Review> receivedReviews;

    /** The list of favorites associated with the user. */
    @OneToMany(mappedBy = "user", cascade = CascadeType.REMOVE)
    private List<Favorite> favorites;

    /** The list of trips associated with the user. */
    @OneToMany(mappedBy = "user",cascade = CascadeType.REMOVE)
    private List<Trip> userTrips;

    /**
     * Retrieves the authorities granted to the user.
     * @return The authorities granted to the user.
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    /**
     * Retrieves the username of the user.
     * @return The username of the user.
     */
    @Override
    public String getUsername() {
        return username;
    }

    /**
     * Indicates whether the user account has not expired.
     * @return true if the user account is valid (i.e., not expired), false otherwise.
     */
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    /**
     * Indicates whether the user account is not locked.
     * @return true if the user account is not locked, false otherwise.
     */
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    /**
     * Indicates whether the user credentials (password) are not expired.
     * @return true if the user credentials are valid (i.e., not expired), false otherwise.
     */
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /**
     * Indicates whether the user is enabled or disabled.
     * @return true if the user is enabled, false otherwise.
     */
    @Override
    public boolean isEnabled() {
        return true;
    }
}