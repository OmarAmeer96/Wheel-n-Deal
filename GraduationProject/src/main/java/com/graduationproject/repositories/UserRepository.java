package com.graduationproject.repositories;

import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User,Integer> {
    Optional<User> findByUsername(String username);
    User findByRole(Role role);
    User findByStripeId(String stripeUserId);
    User findByPhoneNumber(String phoneNumber);
    @Query("SELECT new com.graduationproject.DTOs.UserDTO(u.id, u.phoneNumber, u.username, u.amount, u.gender, u.profilePictureUrl, u.nationalId, u.totalDelivers, u.cancelDelivers) FROM User u WHERE u.id <> 1 AND u.role = :role")
    List<UserDTO> findUsersByRole(@Param("role") Role role);
    @Query("SELECT COUNT(u) FROM User u WHERE u.role = :role")
    long countUsersByRole(@Param("role") Role role);
}