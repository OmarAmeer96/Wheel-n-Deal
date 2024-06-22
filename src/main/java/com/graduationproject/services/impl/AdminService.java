package com.graduationproject.services.impl;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.Role;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    public CustomResponse findUsersByRole(Role role, Integer pageNum, Integer pageSize) {
        try {
            if (role == null) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Role cannot be null",
                        null);
            }

            if (pageNum < 0) {
                return new CustomResponse(
                        HttpStatus.BAD_REQUEST.value(),
                        "Invalid page number or page size",
                        null);
            }

            Pageable page = PageRequest.of(pageNum, pageSize, Sort.by("id"));
            Page<UserDTO> usersPage = userRepository.findUsersByRole(role, page);

            if (usersPage.isEmpty()) {
                return new CustomResponse(
                        HttpStatus.NO_CONTENT.value(),
                        "No users found for the given role",
                        null);
            }

            return new CustomResponse(
                    HttpStatus.OK.value(),
                    "Users found",
                    usersPage);

        } catch (Exception e) {
            return new CustomResponse(
                    HttpStatus.INTERNAL_SERVER_ERROR.value(),
                    "An error occurred: " + e.getMessage(),
                    null);
        }
    }

    public CustomResponse findAllOrders(Integer pageNum, Integer pageSize) {
        try {
            if (pageNum < 0 || pageSize <= 0) {
                return CustomResponse.builder()
                        .status(HttpStatus.BAD_REQUEST.value())
                        .message("Invalid page number or page size")
                        .data(null)
                        .build();
            }

            Pageable page = PageRequest.of(pageNum, pageSize, Sort.by("id"));
            Page<GetAllOrders> orders = orderRepository.findAllOrders(page);

            if (orders.isEmpty()) {
                return CustomResponse.builder()
                        .status(HttpStatus.NO_CONTENT.value())
                        .message("No orders found")
                        .data(null)
                        .build();
            }

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Orders retrieved successfully")
                    .data(orders)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while retrieving orders: " + e.getMessage())
                    .data(null)
                    .build();
        }
    }

    public CustomResponse countAll() {
        try {
            Long customers = userRepository.countUsersByRole(Role.valueOf("USER"));
            Long commuters = userRepository.countUsersByRole(Role.valueOf("COMMUTER"));

            GetNumbersResponseDTO responseDTO = new GetNumbersResponseDTO();
            responseDTO.setNumOfAllUsers(customers+commuters);
            responseDTO.setNumOfCustomers(customers);
            responseDTO.setNumOfCommuters(commuters);
            responseDTO.setTotalRevenue(userRepository.findSumAmount());
            responseDTO.setNumOfAllOrders(orderRepository.countAllOrders());
            responseDTO.setNumOfNotActiveOrders(orderRepository.countOrdersByStatus(OrderStatus.NOT_ACTIVE));
            responseDTO.setNumOfPendingOrders(orderRepository.countOrdersByStatus(OrderStatus.PENDING));
            responseDTO.setNumOfConfirmedOrders(orderRepository.countOrdersByStatus(OrderStatus.CONFIRMED));
            responseDTO.setNumOfInProgressOrders(orderRepository.countOrdersByStatus(OrderStatus.IN_PROGRESS));
            responseDTO.setNumOfInSuccessOrders(orderRepository.countOrdersByStatus(OrderStatus.SUCCESS));
            responseDTO.setNumOfFailedOrders(orderRepository.countOrdersByStatus(OrderStatus.FAILED));
            responseDTO.setNumOfInReturnedOrders(orderRepository.countOrdersByStatus(OrderStatus.RETURNED));

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Counts retrieved successfully")
                    .data(responseDTO)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while counting all entities: " + e.getMessage())
                    .data(null)
                    .build();
        }
    }

    public List<UserCountDTO> getUsersCreatedPerDayLastMonth() {
        Date startDate = Date.from(LocalDate.now().minusMonths(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant());

        List<UserCountDTO> result = new ArrayList<>();

        while (startDate.before(endDate)) {
            Date nextDay = Date.from(startDate.toInstant().plus(1, ChronoUnit.DAYS));
            Long count = userRepository.countUsersCreatedBetween(startDate, nextDay);
            String formattedDate = new SimpleDateFormat("d MMM").format(startDate);
            UserCountDTO userCount = new UserCountDTO(formattedDate, count);
            result.add(userCount);
            startDate = nextDay;
        }

        return result;
    }

    public List<OrderCountDTO> getOrdersCreatedLastWeek() {
        Date startDate = Date.from(LocalDate.now().minusWeeks(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = Date.from(LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant());

        List<OrderCountDTO> result = new ArrayList<>();

        while (startDate.before(endDate)) {
            Date nextDay = Date.from(startDate.toInstant().plus(1, ChronoUnit.DAYS));
            Long count = orderRepository.countOrdersCreatedBetween(startDate, nextDay);
            String formattedDate = new SimpleDateFormat("EEEE").format(startDate);
            result.add(new OrderCountDTO(formattedDate, count));
            startDate = nextDay;
        }

        return result;
    }

//    public Map<String, List<Map<String, Object>>> getUsersCreatedPerDay() {
//        Date startDate = Date.from(LocalDate.now().minusYears(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
//        List<Object[]> results = userRepository.getUsersCreatedPerDay(startDate);
//
//        Map<String, List<Map<String, Object>>> response = new HashMap<>();
//        for (Object[] result : results) {
//            Date date = (Date) result[0];
//            int count = ((Long) result[1]).intValue();
//            String month = new SimpleDateFormat("MMMM").format(date);
//            int day = date.getDate();
//
//            Map<String, Object> dayCount = new HashMap<>();
//            dayCount.put("day", day);
//            dayCount.put("count", count);
//
//            response.computeIfAbsent(month, k -> new ArrayList<>()).add(dayCount);
//        }
//
//        return response;
//    }

    public Map<String, List<Map<String, Object>>> getUsersCreatedPerDay() {
        Date startDate = Date.from(LocalDate.now().minusYears(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
        List<Object[]> results = userRepository.getUsersCreatedPerDay(startDate);

        Map<String, List<Map<String, Object>>> response = new HashMap<>();
        for (int month = 1; month <= 12; month++) {
            String monthName = new SimpleDateFormat("MMMM").format(new Date(2024, month - 1, 1));
            List<Map<String, Object>> dayCounts = new ArrayList<>();

            for (int day = 1; day <= getDaysInMonth(month, 2024); day++) {
                boolean found = false;
                for (Object[] result : results) {
                    Date date = (Date) result[0];
                    if (date.getMonth() == month - 1 && date.getDate() == day) {
                        int count = ((Long) result[1]).intValue();
                        Map<String, Object> dayCount = new HashMap<>();
                        dayCount.put("count", count);
                        dayCount.put("day", day);
                        dayCounts.add(dayCount);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    Map<String, Object> dayCount = new HashMap<>();
                    dayCount.put("day", day);
                    dayCount.put("count", 0);
                    dayCounts.add(dayCount);
                }
            }

            response.put(monthName, dayCounts);
        }

        return response;
    }

    private int getDaysInMonth(int month, int year) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month - 1, 1);
        return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
    }
}

