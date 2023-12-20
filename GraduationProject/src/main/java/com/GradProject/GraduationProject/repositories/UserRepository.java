package com.GraduationProject.test.repositories;

import com.GraduationProject.test.entities.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<AppUser, Long> {
    static Optional<AppUser> getOneByNameAndPassword(String name, String password) {
        return Optional.empty();// modify it
    }

    static AppUser getByName(String name) {
        return null; // modify it
    }
}
