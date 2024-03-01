package com.graduationproject.repositories;

import com.graduationproject.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order,Integer> {
    List<Order> findByFromAndTo(String from, String to);
}
