package com.graduationproject.repositories;

import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository interface for managing user entities in the database.
 */
@Repository
public interface UserRepository extends JpaRepository<User,Integer> {

    /**
     * Finds a user by username.
     * @param username The username of the user.
     * @return An optional containing the user if found, otherwise empty.
     */
    Optional<User> findByUsername(String username);

    /**
     * Finds a user by role.
     * @param role The role of the user.
     * @return The user with the given role.
     */
    User findByRole(Role role);

    /**
     * Finds a user by Stripe user ID.
     * @param stripeUserId The Stripe user ID.
     * @return The user with the given Stripe user ID.
     */
    User findByStripeId(String stripeUserId);

    /**
     * Finds a user by phone number.
     * @param phoneNumber The phone number of the user.
     * @return The user with the given phone number.
     */
    User findByPhoneNumber(String phoneNumber);
}