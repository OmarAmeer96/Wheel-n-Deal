package com.graduationproject.services.impl;

import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.DTOs.TripSearchResultDTO;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.Trip;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.TripRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.*;

@Data
@Service
@RequiredArgsConstructor
public class TripService {

    private final TripRepository tripRepository;
    private final UserRepository userRepository;
    private final OrderService orderService;

    public ResponseEntity<Object> postOrUpdateTrip(TripDTO tripDTO) {
        if (!isCommuter()) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.UNAUTHORIZED.value(), "message", "Access denied. Only COMMUTER users are allowed to access this endpoint."),
                    HttpStatus.UNAUTHORIZED
            );
        }

        if (tripDTO == null) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.BAD_REQUEST.value(), "message", "Trip data cannot be null."),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            if (tripDTO.getId() != null) {
                Optional<Trip> optionalTrip = tripRepository.findById(tripDTO.getId());
                if (optionalTrip.isPresent()) {
                    Trip existingTrip = optionalTrip.get();
                    updateTripFromDTO(existingTrip, tripDTO);
                    tripRepository.save(existingTrip);
                    return new ResponseEntity<>(
                            Map.of("status", HttpStatus.OK.value(), "message", "Trip updated successfully"),
                            HttpStatus.OK
                    );
                } else {
                    return new ResponseEntity<>(
                            Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "Trip not found with ID: " + tripDTO.getId()),
                            HttpStatus.NOT_FOUND
                    );
                }
            } else {
                saveNewTripFromDTO(tripDTO);
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.CREATED.value(), "message", "Trip created successfully"),
                        HttpStatus.CREATED
                );
            }
        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while processing the trip."),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

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

    private void updateTripFromDTO(Trip trip , TripDTO tripDTO){
        trip.setFrom(tripDTO.getFrom());
        trip.setTo(tripDTO.getTo());
        trip.setPaths(tripDTO.getPaths());
        trip.setDay(tripDTO.getDay());
        trip.setStartsAt(tripDTO.getStartsAt());
        trip.setEndsAt(tripDTO.getEndsAt());
        trip.setCapacity(tripDTO.getCapacity());
    }

    public ResponseEntity<Object> deleteTrip(Integer tripId) {
        if (tripId <= 0) {
            return new ResponseEntity<>(
                    Map.of("status", 400, "message", "Invalid tripId provided"),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            tripRepository.deleteById(tripId);

            return new ResponseEntity<>(
                    Map.of("status", 200, "message", "Trip deleted successfully"),
                    HttpStatus.OK
            );

        } catch (EmptyResultDataAccessException e) {
            return new ResponseEntity<>(
                    Map.of("status", 404, "message", "Trip not found with ID: " + tripId),
                    HttpStatus.NOT_FOUND
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", 500, "message", "An error occurred while deleting the trip"),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    public ResponseEntity<Object> searchForTrip(String from, String to) {
        if (!isUser()) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.UNAUTHORIZED.value(), "message", "Access denied. Only authenticated users are allowed to access this endpoint."),
                    HttpStatus.UNAUTHORIZED
            );
        }

        try {
            List<Trip> existingTrips = tripRepository.findByFromAndTo(from, to);

            if (existingTrips.isEmpty()) {
                return new ResponseEntity<>(
                        Map.of("status", HttpStatus.NOT_FOUND.value(), "message", "No trips found from " + from + " to " + to),
                        HttpStatus.NOT_FOUND
                );
            }

            List<TripSearchResultDTO> tripSearchResultDTOS = new ArrayList<>();
            for (Trip trip : existingTrips) {
                TripSearchResultDTO tripResultDetails = new TripSearchResultDTO();
                tripResultDetails.setId(trip.getId());
                tripResultDetails.setFrom(trip.getFrom());
                tripResultDetails.setTo(trip.getTo());
                tripResultDetails.setUsername(trip.getUser().getUsername());
                tripResultDetails.setPhoneNumber(trip.getUser().getPhoneNumber());
                tripResultDetails.setCommuterProfilePhotoURL(trip.getUser().getProfilePictureUrl());
                tripSearchResultDTOS.add(tripResultDetails);
            }

            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.OK.value(), "message", "Trips retrieved successfully", "data", tripSearchResultDTOS),
                    HttpStatus.OK
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", HttpStatus.INTERNAL_SERVER_ERROR.value(), "message", "An error occurred while searching for trips"),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

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

    public ResponseEntity<Object> findCommuterTrips(Integer commuterId) {
        if (commuterId == null || commuterId <= 0) {
            return new ResponseEntity<>(
                    Map.of("status", 400, "message", "Invalid commuterId provided"),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            User commuter = userRepository.findById(commuterId).orElse(null);

            if (commuter == null) {
                return new ResponseEntity<>(
                        Map.of("status", 404, "message", "User not found with ID: " + commuterId),
                        HttpStatus.NOT_FOUND
                );
            }

            List<Trip> trips = tripRepository.findByUser(commuter);

            return new ResponseEntity<>(
                    Map.of("status", 200, "message", "Commuter trips retrieved successfully", "data", trips),
                    HttpStatus.OK
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", 500, "message", "An error occurred while retrieving commuter trips"),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    public ResponseEntity<Object> findTripOrders(Integer tripId) {
        if (tripId == null || tripId <= 0) {
            return new ResponseEntity<>(
                    Map.of("status", 400, "message", "Invalid tripId provided"),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            Optional<Trip> optionalTrip = tripRepository.findById(tripId);

            if (!optionalTrip.isPresent()) {
                return new ResponseEntity<>(
                        Map.of("status", 404, "message", "Trip not found with ID: " + tripId),
                        HttpStatus.NOT_FOUND
                );
            }

            Trip existingTrip = optionalTrip.get();
            List<Order> orderList = existingTrip.getOrders();

            return new ResponseEntity<>(
                    Map.of("status", 200, "message", "Trip orders retrieved successfully", "data", orderList),
                    HttpStatus.OK
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", 500, "message", "An error occurred while retrieving trip orders"),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    public ResponseEntity<Object> cancelTrip(Integer tripId) {
        if (tripId == null || tripId <= 0) {
            return new ResponseEntity<>(
                    Map.of("status", 400, "message", "Invalid tripId provided"),
                    HttpStatus.BAD_REQUEST
            );
        }

        try {
            Optional<Trip> optionalTrip = tripRepository.findById(tripId);

            if (!optionalTrip.isPresent()) {
                return new ResponseEntity<>(
                        Map.of("status", 404, "message", "Trip not found with ID: " + tripId),
                        HttpStatus.NOT_FOUND
                );
            }

            Trip trip = optionalTrip.get();
            Integer commuterId = trip.getUser().getId();

            if (trip.getOrders() != null) {
                List<Order> orderList = trip.getOrders();
                for (Order order : orderList) {
                    orderService.cancelOrder(order.getId(), commuterId);
                }
            }

            tripRepository.deleteById(tripId);

            return new ResponseEntity<>(
                    Map.of("status", 200, "message", "Trip canceled successfully"),
                    HttpStatus.OK
            );

        } catch (Exception e) {
            return new ResponseEntity<>(
                    Map.of("status", 500, "message", "An error occurred while canceling the trip"),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

}