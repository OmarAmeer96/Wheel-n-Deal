package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CommuterTripDTO;
import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.TripDTO;
import com.graduationproject.DTOs.TripSearchResultDTO;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.Trip;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
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
import org.springframework.transaction.annotation.Transactional;

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

    private final OrderService orderService;

    private final OrderRepository orderRepository;


    public CustomResponse postOrUpdateTrip(TripDTO tripDTO) {
        if (!isCommuter()) {
            return CustomResponse.builder()
                    .status(HttpStatus.UNAUTHORIZED.value())
                    .message("Access denied. Only COMMUTER users are allowed to access this endpoint.")
                    .build();
        }

        if (tripDTO.getId() != null) {
            Optional<Trip> optionalTrip = tripRepository.findById(tripDTO.getId());
            if (optionalTrip.isPresent()) {
                Trip existingTrip = optionalTrip.get();
                updateTripFromDTO(existingTrip, tripDTO);
                tripRepository.save(existingTrip);
                return CustomResponse.builder()
                        .status(HttpStatus.OK.value())
                        .message("Trip updated Successfully")
                        .build();
            } else {
                return CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("Trip not found with ID: " + tripDTO.getId())
                        .build();
            }
        } else {
            saveNewTripFromDTO(tripDTO);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Trip Created Successfully")
                    .build();
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

    public CustomResponse deleteTrip(int tripId) {
        try {
            tripRepository.deleteById(tripId);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Trip deleted Successfully")
                    .build();
        } catch (EmptyResultDataAccessException e) {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("Trip not found with ID: " + tripId)
                    .build();
        }
    }



    public CustomResponse searchForTrip(String from, String to) {
        // Check if the user is authorized to access this endpoint
        if (!isUser()) {
            return CustomResponse.builder()
                    .status(HttpStatus.UNAUTHORIZED.value())
                    .message("Access denied. Only authenticated users are allowed to access this endpoint.")
                    .build();
        }

        List<TripSearchResultDTO> tripSearchResultDTOS = new ArrayList<>();
        List<Trip> existingTrips = tripRepository.findByFromAndTo(from, to);
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

        return CustomResponse.builder()
                .status(HttpStatus.OK.value())
                .message("Trips retrieved successfully")
                .data(tripSearchResultDTOS)
                .build();
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


    public CustomResponse findCommuterTrips(Integer commuterId) {
        try {
            User commuter = userRepository.findById(commuterId).orElse(null);
            if (commuter == null) {
                return CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("User not found with ID: " + commuterId)
                        .data(null)
                        .build();
            }

            List<Trip> trips = tripRepository.findByUser(commuter);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Commuter trips retrieved successfully")
                    .data(trips)
                    .build();
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while retrieving commuter trips")
                    .data(null)
                    .build();
        }
    }


    public CustomResponse findTripOrders(Integer tripId) {
        try {
            Optional<Trip> optionalTrip = tripRepository.findById(tripId);
            if (optionalTrip.isPresent()) {
                Trip existingTrip = optionalTrip.get();
                List<Order> orderList = existingTrip.getOrders();
                return CustomResponse.builder()
                        .status(HttpStatus.OK.value())
                        .message("Trip orders retrieved successfully")
                        .data(orderList)
                        .build();
            } else {
                return CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("Trip not found with ID: " + tripId)
                        .data(null)
                        .build();
            }
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while retrieving trip orders")
                    .data(null)
                    .build();
        }
    }


    public CustomResponse cancelTrip(Integer tripId) {
        try {
            Optional<Trip> optionalTrip = tripRepository.findById(tripId);
            if (optionalTrip.isPresent()) {
                Trip trip = optionalTrip.get();
                Integer commuterId = trip.getUser().getId();
                if (trip.getOrders() == null) {
                    tripRepository.deleteById(tripId);
                } else {
                    List<Order> orderList = trip.getOrders();
                    for (Order order : orderList) {
                        orderService.cancleOrder(order.getId(), commuterId);
                    }
                    tripRepository.deleteById(tripId);
                }
                return CustomResponse.builder()
                        .status(HttpStatus.OK.value())
                        .message("Trip canceled successfully")
                        .build();
            } else {
                return CustomResponse.builder()
                        .status(HttpStatus.NOT_FOUND.value())
                        .message("Trip not found")
                        .build();
            }
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while canceling the trip")
                    .build();
        }
    }

    @Transactional
    public CustomResponse createTripAndAssignOrder(TripDTO tripDTO, Integer orderId) {
        Optional<User> optionalCommuter = userRepository.findById(tripDTO.getUserId());
        Optional<Order> optionalOrder= orderRepository.findById(orderId);
        if (optionalOrder.isPresent() && optionalCommuter.isPresent()){
            User commuter = optionalCommuter.get();
            Order order = optionalOrder.get();
            Trip trip = saveNewTripFromDTO(tripDTO);
            order.setCommuter(commuter);
            order.setTrip(trip);
            orderRepository.save(order);
            return CustomResponse.builder().status(200).message("Trip made and Order Assigned to it successfully").build();
        }return CustomResponse.builder().status(404).message("Order does not exist or commuter does not exist.").build();
    }
}