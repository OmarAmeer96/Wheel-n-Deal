package com.graduationproject.services.impl;

import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.DTOs.TripSearchResultDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.Trip;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.TripRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

/**
 * Service class for handling trip-related operations.
 */
@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;
    private final UserRepository userRepository;

    /**
     * Posts or updates a trip based on the provided TripDTO.
     * @param tripDTO The DTO containing trip details
     * @return A ResponseEntity indicating the status of the operation
     */
    public ResponseEntity<String> postOrUpdateTrip(TripDTO tripDTO){

        // Check if the user is a commuter
        if (!isCommuter()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("Access denied. Only COMMUTER users are allowed to access this endpoint.");
        }

        // Check if the trip is being updated or created
        if(tripDTO.getId() != null){
            Optional<Trip> optionalTrip = tripRepository.findById(tripDTO.getId());
            if(optionalTrip.isPresent()){
                Trip existingTrip = optionalTrip.get();
                updateTripFromDTO(existingTrip,tripDTO);
                tripRepository.save(existingTrip);
                return ResponseEntity.ok("Trip updated Successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("Trip not found with ID: " + tripDTO.getId());
            }
        } else {
            saveNewTripFromDTO(tripDTO);
            return ResponseEntity.ok("Trip Created Successfully");
        }
    }

    /**
     * Saves a new trip based on the provided TripDTO.
     * @param tripDTO The DTO containing trip details
     * @return The newly created trip
     */
    private Trip saveNewTripFromDTO(TripDTO tripDTO){
        Optional<User> optionalUser = userRepository.findById(tripDTO.getUserId());
        if (optionalUser.isEmpty()) {
            throw new RuntimeException("User not found with ID: " + tripDTO.getUserId());
        }
        Trip trip = new Trip();
        updateTripFromDTO(trip,tripDTO);
        User user = optionalUser.get();
        trip.setUser(user);
        return tripRepository.save(trip);
    }

    /**
     * Updates a trip entity based on the provided TripDTO.
     * @param trip The trip entity to update
     * @param tripDTO The DTO containing updated trip details
     */
    private void updateTripFromDTO(Trip trip , TripDTO tripDTO){
        trip.setFrom(tripDTO.getFrom());
        trip.setTo(tripDTO.getTo());
        trip.setPaths(tripDTO.getPaths());
        trip.setDay(tripDTO.getDay());
        trip.setStartsAt(tripDTO.getStartsAt());
        trip.setEndsAt(tripDTO.getEndsAt());
        trip.setCapacity(tripDTO.getCapacity());
    }

    /**
     * Deletes a trip with the specified ID.
     * @param tripId The ID of the trip to delete
     * @return A message indicating the status of the operation
     */
    public String deleteTrip(int tripId){
        tripRepository.deleteById(tripId);
        return "Trip deleted Successfully";
    }

    /**
     * Searches for trips based on the specified origin and destination.
     * @param from The origin of the trip
     * @param to The destination of the trip
     * @return A list of TripSearchResultDTO objects representing the search results
     */
    public ResponseEntity<List<TripSearchResultDTO>> searchForTrip(String from, String to){

        // Check if the user is authenticated
        if (!isUser()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.emptyList()); // Return an empty list if unauthorized
        }

        List<TripSearchResultDTO> tripSearchResultDTOS = new ArrayList<>();
        List<Trip> existingTrips = tripRepository.findByFromAndTo(from,to);
        for (Trip trip : existingTrips){
            TripSearchResultDTO tripResultDetails = new TripSearchResultDTO();
            tripResultDetails.setFrom(trip.getFrom());
            tripResultDetails.setTo(trip.getTo());
            tripResultDetails.setUsername(trip.getUser().getUsername());
            tripResultDetails.setPhoneNumber(trip.getUser().getPhoneNumber());
            tripResultDetails.setCommuterProfilePhotoURL(trip.getUser().getProfilePictureUrl());
            tripSearchResultDTOS.add(tripResultDetails);
        }
        return ResponseEntity.ok(tripSearchResultDTOS);
    }

    /**
     * Checks if the authenticated user has the role of a commuter.
     * @return True if the user is a commuter, otherwise false
     */
    private boolean isCommuter(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String authenticatedUsername = authentication.getName();
        String neededRole = String.valueOf(Role.COMMUTER);
        String authenticatedUserRole =String.valueOf(userRepository.findByUsername(authenticatedUsername).get().getRole());
        return neededRole.equals(authenticatedUserRole);
    }

    /**
     * Checks if the authenticated user has the role of a regular user.
     * @return True if the user is a regular user, otherwise false
     */
    private boolean isUser(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String authenticatedUsername = authentication.getName();
        String neededRole = String.valueOf(Role.USER);
        String authenticatedUserRole =String.valueOf(userRepository.findByUsername(authenticatedUsername).get().getRole());
        return neededRole.equals(authenticatedUserRole);
    }
}