package com.graduationproject.repositories;

import com.graduationproject.entities.PaymobResponse;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository interface for managing Paymob response entities in the database.
 */
public interface PaymobResponseRepository extends JpaRepository<PaymobResponse, Long> {
}