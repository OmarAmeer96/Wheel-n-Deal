package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import javax.validation.constraints.NotNull;
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
//    @Column(unique=true,length = 13)
    private String phoneNumber;

    /** The username of the user. */
    @NotNull
    private String username;

    /** The ID associated with the user in the Stripe payment system. */
    @Column(unique=true)
    private String stripeId;

    /** The amount of money associated with the user. */
    private Long amount;

    /** The full name of the user. */
    private String fullName;

    /** The gender of the user. */
    private Gender gender;

    /** The city where the user resides. */
    private String city;

    /** The URL of the user's profile picture. */
    private String profilePictureUrl;

    /** The national ID of the user. */
    @Column(length = 14)
    private String nationalId;

    /** The password of the user. */
    @NotNull
    private String password;

    /** The total number of deliveries made by the user. */
    private Integer totalDelivers;

    /** The number of deliveries cancelled by the user. */
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