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
 * Service class for managing trip-related operations.
 */
@Data
@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;
    private final UserRepository userRepository;

    /**
     * Method to create or update a trip.
     * @param tripDTO The trip DTO containing trip information
     * @return ResponseEntity<String> Response indicating the success or failure of the operation
     */
    public ResponseEntity<String> postOrUpdateTrip(TripDTO tripDTO){

        // Check if the user is authorized to access this endpoint
        if (!isCommuter()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Access denied. Only COMMUTER users are allowed to access this endpoint.");
        }

        // If trip ID exists, update the existing trip, else create a new trip
        if(tripDTO.getId() != null){
            Optional<Trip> optionalTrip = tripRepository.findById(tripDTO.getId());
            if(optionalTrip.isPresent()){
                Trip existingTrip = optionalTrip.get();
                updateTripFromDTO(existingTrip,tripDTO);
                tripRepository.save(existingTrip);
                return ResponseEntity.ok("Trip updated Successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Trip not found with ID: " + tripDTO.getId());
            }
        } else {
            saveNewTripFromDTO(tripDTO);
            return ResponseEntity.ok("Trip Created Successfully");
        }
    }

    /**
     * Method to save a new trip from DTO.
     * @param tripDTO The trip DTO containing trip information
     * @return Trip The saved trip entity
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
     * Method to update trip information from DTO.
     * @param trip The trip entity to be updated
     * @param tripDTO The trip DTO containing updated trip information
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
     * Method to delete a trip by ID.
     * @param tripId The ID of the trip to be deleted
     * @return String A message indicating the success of the deletion operation
     */
    public String deleteTrip(int tripId){
        tripRepository.deleteById(tripId);
        return "Trip deleted Successfully";
    }

    /**
     * Method to search for trips based on origin and destination.
     * @param from The origin of the trip
     * @param to The destination of the trip
     * @return ResponseEntity<List<TripSearchResultDTO>> Response containing trip search results
     */
    public ResponseEntity<List<TripSearchResultDTO>> SearchForTrip(String from, String to){

        // Check if the user is authorized to access this endpoint
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
     * Method to check if the authenticated user is a commuter.
     * @return boolean true if the user is a commuter, false otherwise
     */
    private boolean isCommuter(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String authenticatedUsername = authentication.getName();
        String neededRole = String.valueOf(Role.COMMUTER);
        String authenticatedUserRole =String.valueOf(userRepository.findByUsername(authenticatedUsername).get().getRole());
        if(neededRole.equals(authenticatedUserRole)){
            return true;
        }
        return false;
    }

    /**
     * Method to check if the authenticated user is a regular user.
     * @return boolean true if the user is a regular user, false otherwise
     */
    private boolean isUser(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String authenticatedUsername = authentication.getName();
        String neededRole = String.valueOf(Role.USER);
        String authenticatedUserRole =String.valueOf(userRepository.findByUsername(authenticatedUsername).get().getRole());
        if(neededRole.equals(authenticatedUserRole)){
            return true;
        }
        return false;
    }
}