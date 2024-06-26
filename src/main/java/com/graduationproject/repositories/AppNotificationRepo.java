package com.graduationproject.repositories;


import com.graduationproject.entities.AppNotification;
import com.graduationproject.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AppNotificationRepo extends JpaRepository<AppNotification, Long> {
    List<AppNotification> findByUser(User user);
}
