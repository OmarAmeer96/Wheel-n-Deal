package com.graduationproject.services.impl;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.*;
import com.graduationproject.repositories.*;
import com.graduationproject.utils.Utils;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Data
@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final OrderApplicantsRepository orderApplicantsRepository;
    private final PromoCodeRepository promoCodeRepository;
    private final PromocodeService promocodeService;
    private final TripRepository tripRepository;

    @Transactional
    public ResponseEntity<Object> createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO == null) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.BAD_REQUEST.value(),
                    "message", "OrderDTO cannot be null."
            ), HttpStatus.BAD_REQUEST);
        }

        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();

                // Check if the order status is NOT_ACTIVE (can only update non-active orders)
                if (existingOrder.getOrderStatus().equals(OrderStatus.NOT_ACTIVE)) {
                    updateOrderFromDTO(existingOrder, orderDTO);
                    orderRepository.save(existingOrder);

                    return new ResponseEntity<>(Map.of(
                            "status", HttpStatus.OK.value(),
                            "message", "Order updated successfully"
                    ), HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(Map.of(
                            "status", HttpStatus.FORBIDDEN.value(),
                            "message", "You are allowed to update only non-active orders"
                    ), HttpStatus.FORBIDDEN);
                }
            } else {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.NOT_FOUND.value(),
                        "message", "Order not found with ID: " + orderDTO.getId()
                ), HttpStatus.NOT_FOUND);
            }
        } else {
            ResponseEntity<Object> newOrderResponse = saveNewOrderFromDTO(orderDTO);

            if (newOrderResponse.getStatusCode() == HttpStatus.OK) {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.CREATED.value(),
                        "message", "Order created successfully",
                        "orderId", newOrderResponse.getBody()
                ), HttpStatus.CREATED);
            } else {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.INTERNAL_SERVER_ERROR.value(),
                        "message", "Failed to create order"
                ), HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
    }

    @Transactional
    protected ResponseEntity<Object> saveNewOrderFromDTO(OrderDTO orderDTO) {
        if (orderDTO == null) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.BAD_REQUEST.value(),
                    "message", "OrderDTO cannot be null."
            ), HttpStatus.BAD_REQUEST);
        }

        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());

        // Check if the user exists
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.NOT_FOUND.value(),
                    "message", "User not found with ID: " + orderDTO.getUserId()
            ), HttpStatus.NOT_FOUND);
        }

        // Create a new order if the user exists
        Order order = new Order();
        updateOrderFromDTO(order, orderDTO);

        User user = optionalUser.get();
        order.setUser(user);
        order.setOrderStatus(OrderStatus.NOT_ACTIVE);

        Order savedOrder = orderRepository.save(order);

        return new ResponseEntity<>(Map.of(
                "status", HttpStatus.OK.value(),
                "message", "Order created successfully",
                "orderId", savedOrder.getId()
        ), HttpStatus.OK);
    }

    public ResponseEntity<Object> updateOrderFromDTO(Order order, OrderDTO orderDTO) {
        if (order == null) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.NOT_FOUND.value(),
                    "message", "Order not found."
            ), HttpStatus.NOT_FOUND);
        }

        try {
            if (orderDTO == null) {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.BAD_REQUEST.value(),
                        "message", "OrderDTO is null."
                ), HttpStatus.BAD_REQUEST);
            }

            if (orderDTO.getOrderName() == null || orderDTO.getFrom() == null || orderDTO.getTo() == null) {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.BAD_REQUEST.value(),
                        "message", "Missing required fields in OrderDTO."
                ), HttpStatus.BAD_REQUEST);
            }

            order.setOrderName(orderDTO.getOrderName());
            order.setCountOfOrders(orderDTO.getCountOfOrders());
            order.setWeight(orderDTO.getWeight());
            order.setBreakable(orderDTO.isBreakable());
            order.setExpiryDate(orderDTO.getExpiryDate());
            order.setExpectedPrice(orderDTO.getExpectedPrice());
            order.setOrderPhotoUrl(Utils.storePhotoAndGetUrl(orderDTO.getOrderPhoto()));
            order.setFrom(orderDTO.getFrom());
            order.setTo(orderDTO.getTo());
            order.setSenderName(orderDTO.getSenderName());
            order.setSenderPhoneNumber(orderDTO.getSenderPhoneNumber());
            order.setReceiverName(orderDTO.getReceiverName());
            order.setReceiverPhoneNumber(orderDTO.getReceiverPhoneNumber());

            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.OK.value(),
                    "message", "Order updated successfully.",
                    "data", order
            ), HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.INTERNAL_SERVER_ERROR.value(),
                    "message", "An error occurred while updating the order.",
                    "data", e.getMessage()
            ), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<Object> updateSearchOrderDTOFromOrder(SearchOrderDTO searchOrderDTO, Order order) {
        if (searchOrderDTO == null || order == null) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.BAD_REQUEST.value(),
                    "message", "SearchOrderDTO or Order is null."
            ), HttpStatus.BAD_REQUEST);
        }

        try {
            if (order.getUser() == null || order.getUser().getId() == null) {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.UNPROCESSABLE_ENTITY.value(),
                        "message", "User information is missing in Order."
                ), HttpStatus.UNPROCESSABLE_ENTITY);
            }

            searchOrderDTO.setId(order.getId());
            searchOrderDTO.setOrderName(order.getOrderName());
            searchOrderDTO.setUserId(order.getUser().getId());
            searchOrderDTO.setCountOfOrders(order.getCountOfOrders());
            searchOrderDTO.setWeight(order.getWeight());
            searchOrderDTO.setBreakable(order.isBreakable());
            searchOrderDTO.setExpiryDate(order.getExpiryDate());
            searchOrderDTO.setExpectedPrice(order.getExpectedPrice());
            searchOrderDTO.setOrderPhotoURL(order.getOrderPhotoUrl());
            searchOrderDTO.setFrom(order.getFrom());
            searchOrderDTO.setTo(order.getTo());
            searchOrderDTO.setSenderName(order.getSenderName());
            searchOrderDTO.setSenderPhoneNumber(order.getSenderPhoneNumber());
            searchOrderDTO.setReceiverName(order.getReceiverName());
            searchOrderDTO.setReceiverPhoneNumber(order.getReceiverPhoneNumber());

            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.OK.value(),
                    "message", "SearchOrderDTO updated successfully.",
                    "data", searchOrderDTO
            ), HttpStatus.OK);

        } catch (Exception ex) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.INTERNAL_SERVER_ERROR.value(),
                    "message", "An error occurred while updating SearchOrderDTO.",
                    "data", ex.getMessage()
            ), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<Object> searchForOrder(String from, String to) {
        if (from == null || to == null) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.BAD_REQUEST.value(),
                    "message", "Origin and destination must not be null."
            ), HttpStatus.BAD_REQUEST);
        }

        try {
            List<SearchOrderDTO> searchOrderDTOS = new ArrayList<>();
            List<Order> existingOrders = orderRepository.findByFromAndTo(from, to);

            if (existingOrders == null || existingOrders.isEmpty()) {
                return new ResponseEntity<>(Map.of(
                        "status", HttpStatus.NOT_FOUND.value(),
                        "message", "No orders found between " + from + " and " + to + "."
                ), HttpStatus.NOT_FOUND);
            }

            for (Order order : existingOrders) {
                SearchOrderDTO searchOrderDTO = new SearchOrderDTO();
                ResponseEntity<Object> response = updateSearchOrderDTOFromOrder(searchOrderDTO, order);

                if (response.getStatusCode() != HttpStatus.OK) {
                    return response;
                }

                Map<String, Object> responseBody = (Map<String, Object>) response.getBody();
                SearchOrderDTO updatedSearchOrderDTO = (SearchOrderDTO) responseBody.get("data");
                searchOrderDTOS.add(updatedSearchOrderDTO);
            }

            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.OK.value(),
                    "message", "Search results successfully retrieved.",
                    "data", searchOrderDTOS
            ), HttpStatus.OK);

        } catch (Exception ex) {
            return new ResponseEntity<>(Map.of(
                    "status", HttpStatus.INTERNAL_SERVER_ERROR.value(),
                    "message", "An error occurred during the search.",
                    "data", ex.getMessage()
            ), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ResponseEntity<?> findAllByUserId(Integer userId) {
        if (userId == null || userId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid user ID. User ID must be a positive integer."
                    )
            );
        }

        List<Order> orders = orderRepository.findAllByUserId(userId);

        if (orders.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "No orders found for the user."
                    )
            );
        }

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Orders found.",
                        "data", orders
                )
        );
    }

    public ResponseEntity<Object> findNotActiveOrders(Integer userId) {
        if (userId == null || userId <= 0) {
            return new ResponseEntity<>(
                    Map.of("status", 400, "message", "Invalid userId provided"),
                    HttpStatus.BAD_REQUEST
            );
        }

        List<Order> orders = orderRepository.findNotActiveOrders(userId);

        if (orders == null || orders.isEmpty()) {
            return new ResponseEntity<>(
                    Map.of("status", 404, "message", "No not active orders found for the user"),
                    HttpStatus.NOT_FOUND
            );
        }

        return new ResponseEntity<>(
                Map.of("status", 200, "message", "Not active orders found", "data", orders),
                HttpStatus.OK
        );
    }

    public ResponseEntity<?> assignExistingOrder(Integer orderId, Integer tripId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID."
                    )
            );
        }

        if (tripId == null || tripId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid trip ID."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        Optional<Trip> optionalTrip = tripRepository.findById(tripId);

        if (optionalOrder.isPresent() && optionalTrip.isPresent()) {
            Order existingOrder = optionalOrder.get();
            Trip existingTrip = optionalTrip.get();
            User existingCommuter = existingTrip.getUser();

            if (existingOrder.getCommuter() != null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                        Map.of(
                                "status", HttpStatus.BAD_REQUEST.value(),
                                "message", "Order already assigned"
                        )
                );
            }

            if (existingOrder.getOrderStatus().equals(OrderStatus.NOT_ACTIVE)) {
                existingOrder.setCommuter(existingCommuter);
                existingOrder.setTrip(existingTrip);
                orderRepository.save(existingOrder);

                return ResponseEntity.ok(
                        Map.of(
                                "status", HttpStatus.OK.value(),
                                "message", "Order assigned successfully, waiting for commuter to agree"
                        )
                );
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                        Map.of(
                                "status", HttpStatus.BAD_REQUEST.value(),
                                "message", "Order status must be NOT_ACTIVE to assign it"
                        )
                );
            }
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Error: User ID or Order ID not found"
                    )
            );
        }
    }

    public ResponseEntity<Object> createOrderAndAssignIt(OrderDTO orderDTO, Integer tripId) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        if (optionalUser.isEmpty()) {
            return new ResponseEntity<>(
                    Map.of("status", 404, "message", "User ID not found"),
                    HttpStatus.NOT_FOUND
            );
        }

        Optional<Trip> optionalTrip = tripRepository.findById(tripId);
        if (optionalTrip.isEmpty()) {
            return new ResponseEntity<>(
                    Map.of("status", 404, "message", "Trip ID not found"),
                    HttpStatus.NOT_FOUND
            );
        }

        Order order = new Order();
        updateOrderFromDTO(order, orderDTO);

        User user = optionalUser.get();
        order.setUser(user);

        Trip trip = optionalTrip.get();
        User commuter = trip.getUser();
        order.setCommuter(commuter);
        order.setTrip(trip);

        order.setOrderStatus(OrderStatus.NOT_ACTIVE);

        orderRepository.save(order);

        return new ResponseEntity<>(
                Map.of("status", 200, "message", "Order saved and assigned successfully, waiting for the commuter to agree"),
                HttpStatus.OK
        );
    }

    //the userId in the params refer to user or commuter IDs (who make the cancle)
    public ResponseEntity<?> cancelOrder(Integer orderId, Integer cancelerId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID."
                    )
            );
        }

        if (cancelerId == null || cancelerId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid canceler ID."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found"
                    )
            );
        }

        Order existingOrder = optionalOrder.get();
        OrderStatus orderStatus = existingOrder.getOrderStatus();

        // Who is the canceller
        Role canceller = null;

        // Order owner
        User orderOwner = existingOrder.getUser();

        // This is for who will cancel the order, may be user or commuter
        Optional<User> optionalCancellerUser = userRepository.findById(cancelerId);
        if (optionalCancellerUser.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Canceller not found"
                    )
            );
        }
        User cancellerUser = optionalCancellerUser.get();

        // This is for the commuter that delivers the order (commuter only)
        User commuter = existingOrder.getCommuter();

        User admin = userRepository.findById(1).orElse(null);
        if (admin == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    Map.of(
                            "status", HttpStatus.INTERNAL_SERVER_ERROR.value(),
                            "message", "Admin user not found"
                    )
            );
        }

        if (cancellerUser.equals(orderOwner)) {
            canceller = Role.USER;
        } else if (cancellerUser.equals(commuter)) {
            canceller = Role.COMMUTER;
        }

        // Amount adjustments
        Long orderOwnerAmount = orderOwner.getAmount();
        Long commuterAmount = commuter != null ? commuter.getAmount() : 0L;
        Long adminAmount = admin.getAmount();
        Long orderPrice = (long) existingOrder.getExpectedPrice();

        // Handle order cancellation based on status
        if (orderStatus.equals(OrderStatus.PENDING)) {
            if (canceller.equals(Role.USER)) {
                orderOwnerAmount -= (orderPrice * 10 / 100);
                commuterAmount += (orderPrice * 10 / 100);
            } else if (canceller.equals(Role.COMMUTER)) {
                commuterAmount -= (orderPrice * 10 / 100);
                orderOwnerAmount += (orderPrice * 10 / 100);
            }
            // user pay 200 %
            // commuter pay 10%
        } else if (orderStatus.equals(OrderStatus.IN_PROGRESS)) {
            if (commuter != null) {
                commuter.setCancelDelivers(commuter.getCancelDelivers() + 1);
            }

            if (canceller.equals(Role.USER)) {
                orderOwnerAmount -= (orderPrice * 2);
                    //TODO : make a relation that said that the commuter have x money for order x to give it to him when he return the order
                adminAmount += (orderPrice * 2);
            } else if (canceller.equals(Role.COMMUTER)) {
                commuterAmount -= (orderPrice * 10 / 100);
                PromoCode promoCode = new PromoCode();
                promoCode.setUser(orderOwner);
                promocodeService.generatePromoCode(orderId);
                promoCode.setPromocodeStatus(PromocodeStatus.ACTIVE);
                promoCode.setDiscountAmount(orderPrice * 10 / 100);
            }
            // The other will take 10%
        } else if (orderStatus.equals(OrderStatus.CONFIRMED)) {
            if (canceller.equals(Role.USER)) {
                orderOwnerAmount -= (orderPrice * 10 / 100);
                commuterAmount += (orderPrice * 10 / 100);
            } else if (canceller.equals(Role.COMMUTER)) {
                commuterAmount -= (orderPrice * 10 / 100);
                orderOwnerAmount += (orderPrice * 10 / 100);
            }
        }

        // Update amounts and save entities
        orderOwner.setAmount(orderOwnerAmount);
        if (commuter != null) commuter.setAmount(commuterAmount);
        admin.setAmount(adminAmount);
        existingOrder.setOrderStatus(OrderStatus.FAILED);

        userRepository.save(orderOwner);
        if (commuter != null) userRepository.save(commuter);
        userRepository.save(admin);
        orderRepository.save(existingOrder);

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Order canceled successfully"
                )
        );
    }

    public ResponseEntity<?> findCommuterOrders(Integer commuterId) {
        if (commuterId == null || commuterId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid commuter ID"
                    )
            );
        }

        Optional<User> optionalCommuter = userRepository.findById(commuterId);
        if (!optionalCommuter.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Commuter ID not found"
                    )
            );
        }

        List<Order> orderList = orderRepository.findCommuterOrders(commuterId);
        if (orderList.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(
                    Map.of(
                            "status", HttpStatus.NO_CONTENT.value(),
                            "message", "No orders found for this commuter"
                    )
            );
        }

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Orders retrieved successfully",
                        "data", orderList
                )
        );
    }

    public ResponseEntity<?> negotiate(NegotiationDTO negotiationDTO) {
        if (negotiationDTO == null || negotiationDTO.getOrderId() == null || negotiationDTO.getNewPrice() == null) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid negotiation details. Order ID and new price are required."
                    )
            );
        }

        if (negotiationDTO.getNewPrice() <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid price. Price must be greater than zero."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(negotiationDTO.getOrderId());
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found"
                    )
            );
        }

        Order existingOrder = optionalOrder.get();
        existingOrder.setNegotiationPrice(negotiationDTO.getNewPrice());
        orderRepository.save(existingOrder);

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Negotiation successful. We will inform the customer about the new price and await their response."
                )
        );
    }

    public ResponseEntity<?> pickOrder(OrderPickDTO orderPickDTO) {
        Integer orderId = orderPickDTO.getOrderId();
        Integer commuterId = orderPickDTO.getCommuterId();
        double price = orderPickDTO.getApllicantPrice();

        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID."
                    )
            );
        }

        if (commuterId == null || commuterId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid commuter ID."
                    )
            );
        }

        if (price <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Price must be greater than zero."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order does not exist."
                    )
            );
        }

        Order existingOrder = optionalOrder.get();

        Optional<User> optionalCommuter = userRepository.findById(commuterId);
        if (!optionalCommuter.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Commuter does not exist."
                    )
            );
        }

        User existingCommuter = optionalCommuter.get();

        OrderApplicants orderApplicants = orderApplicantsRepository.findByOrderAndCommuter(existingOrder, existingCommuter);
        if (orderApplicants != null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "You have already given an offer before. Please be patient until the user sees your offer."
                    )
            );
        }

        OrderApplicants orderApplicant = new OrderApplicants();
        orderApplicant.setCommuter(existingCommuter);
        orderApplicant.setOrder(existingOrder);
        orderApplicant.setApllicantPrice(price);

        orderApplicantsRepository.save(orderApplicant);

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Order picked successfully. We will inform you when the user accepts."
                )
        );
    }

    public ResponseEntity<?> getOrderApplicants(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();

            List<OrderApplicants> orderApplicationList = orderApplicantsRepository.findByOrder(existingOrder);

            if (orderApplicationList == null || orderApplicationList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                        Map.of(
                                "status", HttpStatus.NOT_FOUND.value(),
                                "message", "No applicants found for this order."
                        )
                );
            }

            List<ApplicantDTO> applicantDTOList = new ArrayList<>();
            for (OrderApplicants orderApplicant : orderApplicationList) {
                ApplicantDTO applicantDTO = new ApplicantDTO();
                applicantDTO.setFullName(orderApplicant.getCommuter().getFullName());
                applicantDTO.setPrice(orderApplicant.getApllicantPrice());
                applicantDTO.setCommuterPhotoURL(orderApplicant.getCommuter().getProfilePictureUrl());
                applicantDTO.setCommuterId(orderApplicant.getCommuter().getId());
                applicantDTOList.add(applicantDTO);
            }

            return ResponseEntity.ok(
                    Map.of(
                            "status", HttpStatus.OK.value(),
                            "message", "Applicants found for the order",
                            "data", applicantDTOList
                    )
            );
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found"
                    )
            );
        }
    }

    public ResponseEntity<?> confirmPickingUp(ConfirmPickingUpDTO confirmPickingUpDTO) {
        double actualPrice = confirmPickingUpDTO.getPrice();
        double appPenefits = actualPrice * 7 / 100;
        double commuterMoney = actualPrice - appPenefits;
        Integer orderId = confirmPickingUpDTO.getOrderId();
        Integer commuterId = confirmPickingUpDTO.getCommuterId();

        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID."
                    )
            );
        }

        if (commuterId == null || commuterId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid commuter ID."
                    )
            );
        }

        Optional<User> optionalCommuter = userRepository.findById(commuterId);
        if (optionalCommuter.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Commuter not found"
                    )
            );
        }
        User commuter = optionalCommuter.get();

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found"
                    )
            );
        }
        Order existingOrder = optionalOrder.get();
        User user = existingOrder.getUser();

        PaymentMethod paymentMethod = confirmPickingUpDTO.getPaymentMethod();
        String promoCode = confirmPickingUpDTO.getPromoCode();

        if (paymentMethod.equals(PaymentMethod.WALLET)) {
            if (promoCode == null) {
                // Decrease user amount and increase admin amount
                Long userAmount = user.getAmount();
                userAmount -= (long) actualPrice;
                user.setAmount(userAmount);

                User admin = userRepository.findById(1).orElse(null);
                if (admin != null) {
                    Long adminAmount = admin.getAmount();
                    adminAmount += (long) actualPrice;
                    admin.setAmount(adminAmount);

                    existingOrder.setOrderStatus(OrderStatus.PENDING);
                    Integer commuterTotalDelivers = commuter.getTotalDelivers();
                    commuterTotalDelivers++;
                    commuter.setTotalDelivers(commuterTotalDelivers);

                    userRepository.save(admin);
                    userRepository.save(user);
                    existingOrder.setCommuter(commuter);
                    orderRepository.save(existingOrder);

                    return ResponseEntity.ok(
                            Map.of(
                                    "status", HttpStatus.OK.value(),
                                    "message", "Order assigned successfully. Proceed to pick it up."
                            )
                    );
                }
            } else if (promocodeService.checkPromoCode(promoCode)) {
                PromoCode promoCode1 = promoCodeRepository.findByPromoCode(promoCode);
                if (promoCode1 != null && promoCode1.getUser().equals(user)
                        && promoCode1.getPromocodeStatus().equals(PromocodeStatus.ACTIVE)) {
                    actualPrice -= promoCode1.getDiscountAmount();

                    Long userAmount = user.getAmount();
                    userAmount -= (long) actualPrice;
                    user.setAmount(userAmount);

                    User admin = userRepository.findById(1).orElse(null);
                    if (admin != null) {
                        Long adminAmount = admin.getAmount();
                        adminAmount += (long) actualPrice;
                        admin.setAmount(adminAmount);

                        existingOrder.setOrderStatus(OrderStatus.PENDING);
                        promoCode1.setPromocodeStatus(PromocodeStatus.NON_ACTIVE);

                        userRepository.save(admin);
                        userRepository.save(user);
                        existingOrder.setCommuter(commuter);
                        orderRepository.save(existingOrder);

                        return ResponseEntity.ok(
                                Map.of(
                                        "status", HttpStatus.OK.value(),
                                        "message", "Order assigned successfully. Proceed to pick it up."
                                )
                        );
                    }
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                            Map.of(
                                    "status", HttpStatus.BAD_REQUEST.value(),
                                    "message", "This promo code does not belong to this user or is not active."
                            )
                    );
                }
            }
        }
        // Handle payment method - CASH
        else if (paymentMethod.equals(PaymentMethod.CASH)) {
            existingOrder.setCommuter(commuter);
            existingOrder.setOrderStatus(OrderStatus.PENDING);
            orderRepository.save(existingOrder);

            return ResponseEntity.ok(
                    Map.of(
                            "status", HttpStatus.OK.value(),
                            "message", "Order assigned successfully. Proceed to pick it up."
                    )
            );
        }

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                Map.of(
                        "status", HttpStatus.BAD_REQUEST.value(),
                        "message", "Invalid payment method."
                )
        );
    }

    public ResponseEntity<?> findById(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID. Order ID must be a positive integer."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found."
                    )
            );
        }

        Order order = optionalOrder.get();
        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Order found.",
                        "data", order
                )
        );
    }

    public ResponseEntity<?> declineOrder(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID. Order ID must be a positive integer."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found"
                    )
            );
        }

        Order order = optionalOrder.get();
        if (order.getCommuter() == null) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(
                    Map.of(
                            "status", HttpStatus.CONFLICT.value(),
                            "message", "Order has no assigned commuter to decline."
                    )
            );
        }

        order.setCommuter(null);
        orderRepository.save(order);

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Order declined successfully."
                )
        );
    }

    public ResponseEntity<?> confirmOrder(Integer orderId) {
        if (orderId == null || orderId <= 0) {
            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", HttpStatus.BAD_REQUEST.value(),
                            "message", "Invalid order ID. Order ID must be a positive integer."
                    )
            );
        }

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (!optionalOrder.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                    Map.of(
                            "status", HttpStatus.NOT_FOUND.value(),
                            "message", "Order not found."
                    )
            );
        }

        Order order = optionalOrder.get();

        if (order.getOrderStatus() == OrderStatus.PENDING || order.getOrderStatus() == OrderStatus.CONFIRMED) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(
                    Map.of(
                            "status", HttpStatus.CONFLICT.value(),
                            "message", "Order is already confirmed or completed."
                    )
            );
        }

        order.setOrderStatus(OrderStatus.PENDING);
        orderRepository.save(order);

        return ResponseEntity.ok(
                Map.of(
                        "status", HttpStatus.OK.value(),
                        "message", "Order confirmed successfully. Go and pick it up."
                )
        );
    }

}