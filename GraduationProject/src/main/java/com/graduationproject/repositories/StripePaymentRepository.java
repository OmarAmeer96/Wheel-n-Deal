package com.graduationproject.repositories;

import com.graduationproject.entities.StripePaymentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface StripePaymentRepository extends JpaRepository<StripePaymentEntity, Long> {
}
