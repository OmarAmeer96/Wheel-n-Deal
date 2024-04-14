package com.graduationproject.repositories;

import com.graduationproject.entities.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository interface for managing trip entities in the database.
 */
@Repository
public interface TripRepository extends JpaRepository<Trip,Integer> {

    /**
     * Retrieves a list of trips based on the starting location and destination.
     * @param from The starting location.
     * @param to The destination.
     * @return A list of trips matching the given starting location and destination.
     */
    List<Trip> findByFromAndTo(String from, String to);
}