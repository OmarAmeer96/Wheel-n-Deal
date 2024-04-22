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
                    .status(400)
                    .message("Trip data must be provided.")
                    .build();
        }

        if (!isCommuter()) {
            return CustomResponse.builder()
                    .status(401)
                    .message("Access denied. Only COMMUTER users are allowed to access this endpoint.")
                    .build();
        }

        try {
            if (tripDTO.getId() != null) {
                Optional<Trip> optionalTrip = tripRepository.findById(tripDTO.getId());
                if (optionalTrip.isPresent()) {
                    Trip existingTrip = optionalTrip.get();
                    updateTripFromDTO(existingTrip, tripDTO);
                    tripRepository.save(existingTrip);

                    return CustomResponse.builder()
                            .status(200)
                            .message("Trip updated successfully.")
                            .data(existingTrip)
                            .build();

                } else {
                    return CustomResponse.builder()
                            .status(404)
                            .message("Trip not found with ID: " + tripDTO.getId())
                            .build();
                }
            } else {
                CustomResponse newTrip = saveNewTripFromDTO(tripDTO);
                return CustomResponse.builder()
                        .status(200)
                        .message("Trip created successfully.")
                        .data(newTrip)
                        .build();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred while processing the trip request.")
                    .data(e.getMessage())
                    .build();
        }
    }

    public CustomResponse saveNewTripFromDTO(TripDTO tripDTO) {
        if (tripDTO == null) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Trip data must be provided.")
                    .build();
        }

        Integer userId = tripDTO.getUserId();
        if (userId == null || userId <= 0) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Valid User ID must be provided.")
                    .build();
        }

        try {
            Optional<User> optionalUser = userRepository.findById(tripDTO.getUserId());
            if (optionalUser.isEmpty()) {
                return CustomResponse.builder()
                        .status(404)
                        .message("User not found with ID: " + tripDTO.getUserId())
                        .build();
            }

            Trip trip = new Trip();
            updateTripFromDTO(trip, tripDTO);

            User user = optionalUser.get();
            trip.setUser(user);

            Trip savedTrip = tripRepository.save(trip);

            return CustomResponse.builder()
                    .status(201)
                    .message("Trip created successfully.")
                    .data(savedTrip)
                    .build();

        } catch (Exception e) {
            e.printStackTrace();
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred while saving the trip.")
                    .data(e.getMessage())
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
        if (tripId == null || tripId <= 0) {
            return CustomResponse.builder()
                    .status(400)
                    .message("A valid Trip ID must be provided.")
                    .build();
        }

        try {
            Optional<Trip> optionalTrip = tripRepository.findById(tripId);

            if (optionalTrip.isEmpty()) {
                return CustomResponse.builder()
                        .status(404)
                        .message("Trip not found with ID: " + tripId)
                        .build();
            }

            tripRepository.deleteById(tripId);

            return CustomResponse.builder()
                    .status(200)
                    .message("Trip deleted successfully.")
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .message("An error occurred while deleting the trip.")
                    .data(e.getMessage())
                    .build();
        }
    }

    public CustomResponse searchForTrip(String from, String to) {
        if (!isUser()) {
            return CustomResponse.builder()
                            .status(401)
                            .message("Access denied. Only authorized users are allowed to search for trips.")
                            .build();
        }

        if (from == null || from.isBlank() || to == null || to.isBlank()) {
            return CustomResponse.builder()
                            .status(400)
                            .message("Both 'from' and 'to' locations must be provided and cannot be empty.")
                            .build();
        }

        try {
            List<TripSearchResultDTO> tripSearchResultDTOS = new ArrayList<>();
            List<Trip> existingTrips = tripRepository.findByFromAndTo(from, to);

            if (existingTrips.isEmpty()) {
                return CustomResponse.builder()
                                .status(200)
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
                    .status(200)
                    .message("Trips found successfully.")
                    .data(tripSearchResultDTOS)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                            .status(500)
                            .message("An error occurred while searching for trips.")
                            .data(e.getMessage())
                            .build();
        }
    }

    private boolean isCommuter() {
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

            return Role.COMMUTER.equals(userRole);

        } catch (Exception e) {
            e.printStackTrace();
            return false;
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