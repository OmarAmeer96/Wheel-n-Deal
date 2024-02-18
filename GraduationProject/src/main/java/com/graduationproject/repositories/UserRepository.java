package com.graduationproject.repositories;

import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface UserRepository extends JpaRepository<User,Integer> {
    Optional<User> findByUsername(String username);
    User findByRole(Role role);
    User findByStripeId(String stripeUserId);
}
