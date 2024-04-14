package com.graduationproject.repositories;

import com.graduationproject.entities.StripePaymentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repository interface for managing Stripe payment entities in the database.
 */
public interface StripePaymentRepository extends JpaRepository<StripePaymentEntity, Long> {
}