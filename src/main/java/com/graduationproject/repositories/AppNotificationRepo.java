package com.graduationproject.repositories;


import com.graduationproject.entities.AppNotification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppNotificationRepo extends JpaRepository<AppNotification, Long> {
}
