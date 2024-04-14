package com.graduationproject.repositories;

import com.graduationproject.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

/**
 * Repository interface for managing order entities in the database.
 */
public interface OrderRepository extends JpaRepository<Order,Integer> {

    /**
     * Retrieves a list of orders based on the starting location and destination.
     * @param from The starting location.
     * @param to The destination.
     * @return A list of orders matching the given starting location and destination.
     */
    List<Order> findByFromAndTo(String from, String to);
}