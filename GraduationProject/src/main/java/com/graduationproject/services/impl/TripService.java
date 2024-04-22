package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
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

@Data
@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;
    private final UserRepository userRepository;

    public CustomResponse postOrUpdateTrip(TripDTO tripDTO) {
        if (tripDTO == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Trip data must be provided.")
                    .build();
        }

        // Check if the user is authorized to access this endpoint
        if (!isCommuter()) {
            return CustomResponse.builder()
                    .status(401)  // HTTP Unauthorized
                    .message("Access denied. Only COMMUTER users are allowed to access this endpoint.")
                    .build();
        }

        try {
            // If trip ID exists, update the existing trip, else create a new trip
            if (tripDTO.getId() != null) {
                Optional<Trip> optionalTrip = tripRepository.findById(tripDTO.getId());
                if (optionalTrip.isPresent()) {
                    Trip existingTrip = optionalTrip.get();
                    updateTripFromDTO(existingTrip, tripDTO);  // Assume this method handles updating trip
                    tripRepository.save(existingTrip);  // Save updated trip

                    return CustomResponse.builder()
                            .status(200)  // HTTP OK
                            .message("Trip updated successfully.")
                            .data(existingTrip)  // Include the updated trip data
                            .build();

                } else {
                    return CustomResponse.builder()
                            .status(404)  // HTTP Not Found
                            .message("Trip not found with ID: " + tripDTO.getId())
                            .build();
                }
            } else {
                // Create a new trip
                CustomResponse newTrip = saveNewTripFromDTO(tripDTO);  // Assume this method creates and returns the new trip
                return CustomResponse.builder()
                        .status(200)  // HTTP OK
                        .message("Trip created successfully.")
                        .data(newTrip)  // Include the new trip data
                        .build();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred while processing the trip request.")
                    .data(e.getMessage())  // Include exception message for debugging
                    .build();
        }
    }

    public CustomResponse saveNewTripFromDTO(TripDTO tripDTO) {
        // Check if tripDTO is null
        if (tripDTO == null) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Trip data must be provided.")
                    .build();
        }

        // Validate the userId
        Integer userId = tripDTO.getUserId();  // Assuming userId is an Integer
        if (userId == null || userId <= 0) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("Valid User ID must be provided.")
                    .build();
        }

        try {
            // Find the user by ID
            Optional<User> optionalUser = userRepository.findById(tripDTO.getUserId());
            if (optionalUser.isEmpty()) {
                return CustomResponse.builder()
                        .status(404)  // HTTP Not Found
                        .message("User not found with ID: " + tripDTO.getUserId())
                        .build();
            }

            // Create a new trip and update its data from the DTO
            Trip trip = new Trip();
            updateTripFromDTO(trip, tripDTO);

            // Associate the trip with the user
            User user = optionalUser.get();
            trip.setUser(user);

            // Save the new trip to the repository
            Trip savedTrip = tripRepository.save(trip);

            return CustomResponse.builder()
                    .status(201)  // HTTP Created
                    .message("Trip created successfully.")
                    .data(savedTrip)  // Include the saved trip data
                    .build();

        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred while saving the trip.")
                    .data(e.getMessage())  // Include exception message for debugging
                    .build();
        }
    }

    /////////////////////////////////////////////////////
    private void updateTripFromDTO(Trip trip , TripDTO tripDTO){
        trip.setFrom(tripDTO.getFrom());
        trip.setTo(tripDTO.getTo());
        trip.setPaths(tripDTO.getPaths());
        trip.setDay(tripDTO.getDay());
        trip.setStartsAt(tripDTO.getStartsAt());
        trip.setEndsAt(tripDTO.getEndsAt());
        trip.setCapacity(tripDTO.getCapacity());
    }

    public CustomResponse deleteTrip(Integer tripId) {
        // Validate the tripId
        if (tripId == null || tripId <= 0) {
            return CustomResponse.builder()
                    .status(400)  // HTTP Bad Request
                    .message("A valid Trip ID must be provided.")
                    .build();
        }

        try {
            Optional<Trip> optionalTrip = tripRepository.findById(tripId);

            if (optionalTrip.isEmpty()) {
                return CustomResponse.builder()
                        .status(404)  // HTTP Not Found
                        .message("Trip not found with ID: " + tripId)
                        .build();
            }

            // If the trip exists, proceed with deletion
            tripRepository.deleteById(tripId);

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("Trip deleted successfully.")
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(500)  // HTTP Internal Server Error
                    .message("An error occurred while deleting the trip.")
                    .data(e.getMessage())  // Optional: Include exception message for debugging
                    .build();
        }
    }

    public CustomResponse searchForTrip(String from, String to) {
        // Check if the user is authorized to access this endpoint
        if (!isUser()) {
            return CustomResponse.builder()
                            .status(401)  // HTTP Unauthorized
                            .message("Access denied. Only authorized users are allowed to search for trips.")
                            .build();
        }

        if (from == null || from.isBlank() || to == null || to.isBlank()) {
            return CustomResponse.builder()
                            .status(400)  // HTTP Bad Request
                            .message("Both 'from' and 'to' locations must be provided and cannot be empty.")
                            .build();
        }

        try {
            List<TripSearchResultDTO> tripSearchResultDTOS = new ArrayList<>();
            List<Trip> existingTrips = tripRepository.findByFromAndTo(from, to);

            if (existingTrips.isEmpty()) {
                return CustomResponse.builder()
                                .status(200)  // HTTP OK
                                .message("No trips found matching the given criteria.")
                                .data(Collections.emptyList())
                                .build();
            }

            for (Trip trip : existingTrips) {
                TripSearchResultDTO tripResultDetails = new TripSearchResultDTO();
                tripResultDetails.setFrom(trip.getFrom());
                tripResultDetails.setTo(trip.getTo());
                tripResultDetails.setUsername(trip.getUser().getUsername());
                tripResultDetails.setPhoneNumber(trip.getUser().getPhoneNumber());
                tripResultDetails.setCommuterProfilePhotoURL(trip.getUser().getProfilePictureUrl());
                tripSearchResultDTOS.add(tripResultDetails);
            }

            return CustomResponse.builder()
                    .status(200)  // HTTP OK
                    .message("Trips found successfully.")
                    .data(tripSearchResultDTOS)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                            .status(500)  // HTTP Internal Server Error
                            .message("An error occurred while searching for trips.")
                            .data(e.getMessage())  // Optional: include the error message for debugging
                            .build();
        }
    }

    private boolean isCommuter() {
        // Get the current authentication
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return false; // User is not authenticated
        }

        try {
            String authenticatedUsername = authentication.getName();

            Optional<User> optionalUser = userRepository.findByUsername(authenticatedUsername);
            if (optionalUser.isEmpty()) {
                return false; // User with this username not found
            }

            User authenticatedUser = optionalUser.get();
            Role userRole = authenticatedUser.getRole();

            return Role.COMMUTER.equals(userRole); // Check if the user's role is COMMUTER

        } catch (Exception e) {
            // Handle exceptions such as NPE or database issues
            e.printStackTrace(); // Log the exception
            return false; // In case of an error, assume the user is not a COMMUTER
        }
    }

    public boolean isUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }

        try {
            String authenticatedUsername = authentication.getName();

            Optional<User> optionalUser = userRepository.findByUsername(authenticatedUsername);
            if (optionalUser.isEmpty()) {
                return false;
            }

            User authenticatedUser = optionalUser.get();
            Role userRole = authenticatedUser.getRole();

            return Role.USER.equals(userRole);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}