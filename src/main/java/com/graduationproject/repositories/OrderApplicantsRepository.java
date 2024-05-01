package com.graduationproject.repositories;

import com.graduationproject.entities.Order;
import com.graduationproject.entities.OrderApplicants;
import com.graduationproject.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderApplicantsRepository extends JpaRepository<OrderApplicants,Integer> {
    OrderApplicants findByOrderAndCommuter(Order order, User commuter);
    List<OrderApplicants> findByOrder(Order order);
}
