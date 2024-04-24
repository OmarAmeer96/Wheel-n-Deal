package com.graduationproject.repositories;

import com.graduationproject.entities.PaymobResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PaymobResponseRepository extends JpaRepository<PaymobResponse, Long> {
}