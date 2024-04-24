package com.graduationproject.repositories;

import com.graduationproject.entities.PromoCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PromoCodeRepository extends JpaRepository<PromoCode,Integer> {
    PromoCode findByPromoCode(String promoCode);
}
