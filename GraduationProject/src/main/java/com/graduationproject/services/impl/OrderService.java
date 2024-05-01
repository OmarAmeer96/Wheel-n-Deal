package com.graduationproject.services.impl;

import com.graduationproject.DTOs.*;
import com.graduationproject.entities.*;
import com.graduationproject.repositories.*;
import com.graduationproject.utils.Utils;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Service class responsible for managing orders.
 */
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
    public CustomResponse createOrUpdateOrder(OrderDTO orderDTO) {
        if (orderDTO.getId() != null) {
            Optional<Order> optionalOrder = orderRepository.findById(orderDTO.getId());

            if (optionalOrder.isPresent()) {
                Order existingOrder = optionalOrder.get();
                if (existingOrder.getOrderStatus().equals(OrderStatus.NOT_ACTIVE)){
                updateOrderFromDTO(existingOrder, orderDTO);
                orderRepository.save(existingOrder);
                return CustomResponse.builder().status(HttpStatus.OK.value()).message("Order updated Successfully").build();
                }else {
                    return CustomResponse.builder().status(HttpStatus.FORBIDDEN.value()).message("You are allowed only for updating non active orders").build();
                }
            } else {
                return CustomResponse.builder().status(HttpStatus.NOT_FOUND.value()).message("Order not found with ID: " + orderDTO.getId()).build();
            }
        } else {
            CustomResponse newOrder = saveNewOrderFromDTO(orderDTO);
            if (newOrder != null) {
                return CustomResponse.builder().status(HttpStatus.OK.value()).message("Order Created Successfully").data(Map.of("orderId", newOrder.getData().toString())).build();
            } else {
                return CustomResponse.builder().status(HttpStatus.INTERNAL_SERVER_ERROR.value()).message("Failed to create order").build();
            }
        }
    }


    @Transactional
    protected CustomResponse saveNewOrderFromDTO(OrderDTO orderDTO) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        if (optionalUser.isPresent()) {
            Order order = new Order();
            updateOrderFromDTO(order, orderDTO);

            User user = optionalUser.get();
            order.setUser(user);
            order.setOrderStatus(OrderStatus.NOT_ACTIVE);

            Order savedOrder = orderRepository.save(order);

            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("Order Created Successfully")
                    .data(Map.of("orderId", savedOrder.getId().toString()))
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("User not found with ID: " + orderDTO.getUserId())
                    .build();
        }
    }

    public CustomResponse updateOrderFromDTO(Order order, OrderDTO orderDTO) {
        if (order == null) {
            return CustomResponse.builder()
                    .status(404)
                    .message("Order not found.")
                    .build();
        }

        try {
            if (orderDTO == null) {
                return CustomResponse.builder()
                        .status(400)
                        .message("OrderDTO is null.")
                        .build();
            }

            if (orderDTO.getOrderName() == null || orderDTO.getFrom() == null || orderDTO.getTo() == null) {
                return CustomResponse.builder()
                        .status(400)
                        .message("Missing required fields in OrderDTO.")
                        .build();
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

            return CustomResponse.builder()
                    .status(200)
                    .message("Order updated successfully.")
                    .data(order)
                    .build();

        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred while updating the order.")
                    .data(e.getMessage())
                    .build();
        }
    }

    public CustomResponse updateSearchOrderDTOFromOrder(SearchOrderDTO searchOrderDTO, Order order) {
        if (searchOrderDTO == null || order == null) {
            return CustomResponse.builder()
                    .status(400)
                    .message("SearchOrderDTO or Order is null.")
                    .build();
        }

        try {
            if (order.getUser() == null || order.getUser().getId() == null) {
                return CustomResponse.builder()
                        .status(422)
                        .message("User information is missing in Order.")
                        .build();
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

            return CustomResponse.builder()
                    .status(200)
                    .message("SearchOrderDTO updated successfully.")
                    .data(searchOrderDTO)
                    .build();

        } catch (Exception ex) {
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred while updating SearchOrderDTO.")
                    .data(ex.getMessage())
                    .build();
        }
    }


    public CustomResponse searchForOrder(String from, String to) {
        if (from == null || to == null) {
            return CustomResponse.builder()
                    .status(400)
                    .message("Origin and destination must not be null.")
                    .build();
        }

        try {
            List<SearchOrderDTO> searchOrderDTOS = new ArrayList<>();
            List<Order> existingOrders = orderRepository.findByFromAndTo(from, to);

            if (existingOrders == null || existingOrders.isEmpty()) {
                return CustomResponse.builder()
                        .status(404)
                        .message("No orders found between " + from + " and " + to + ".")
                        .build();
            }

            for (Order order : existingOrders) {
                SearchOrderDTO searchOrderDTO = new SearchOrderDTO();
                CustomResponse response = updateSearchOrderDTOFromOrder(searchOrderDTO, order);

                if (response.getStatus() == 200) {
                    searchOrderDTOS.add((SearchOrderDTO) response.getData());
                } else {
                    return response;
                }
            }

            return CustomResponse.builder()
                    .status(200)
                    .message("Search results successfully retrieved.")
                    .data(searchOrderDTOS)
                    .build();

        } catch (Exception ex) {
            return CustomResponse.builder()
                    .status(500)
                    .message("An error occurred during the search.")
                    .data(ex.getMessage())
                    .build();
        }
    }



    public CustomResponse findAllByUserId(Integer userId) {
        List<Order> orders = orderRepository.findAllByUserId(userId);
        if (!orders.isEmpty()) {
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Orders found")
                    .data(orders)
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("No orders found for the user")
                    .build();
        }
    }


    public CustomResponse findNotActiveOrders(Integer userId) {
        List<Order> orders = orderRepository.findNotActiveOrders(userId);
        if (!orders.isEmpty()) {
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Not active orders found")
                    .data(orders)
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("No not active orders found for the user")
                    .build();
        }
    }




    public CustomResponse assignExistingOrder(Integer orderId, Integer tripId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        Optional<Trip> optionalTrip = tripRepository.findById(tripId);
        if (optionalOrder.isPresent() && optionalTrip.isPresent()) {

            Order existingOrder = optionalOrder.get();
            Trip existingTrip = optionalTrip.get();
            User existingCommuter = optionalTrip.get().getUser();

            if (existingOrder.getCommuter() != null){
                return CustomResponse.builder()
                        .status(400) // You can set appropriate status codes
                        .message("Order already assigned")
                        .build();
            } else if (existingOrder.getOrderStatus().equals(OrderStatus.NOT_ACTIVE)){

                    existingOrder.setCommuter(existingCommuter);
                    existingOrder.setTrip(existingTrip);
                    orderRepository.save(existingOrder);

                    return CustomResponse.builder()
                            .status(200)
                            .message("Order assigned successfully, waiting for commuter to agree")
                            .build();

                }else {
                    return CustomResponse.builder()
                            .status(400)
                            .message("Order status must be NOT_ACTIVE to assign it")
                            .build();
                }
        } else return CustomResponse.builder()
                .status(404)
                .message("Error: User ID or Order ID not found")
                .build();
    }



    public CustomResponse createOrderAndAssignIt(OrderDTO orderDTO, Integer tripId) {
        Optional<User> optionalUser = userRepository.findById(orderDTO.getUserId());
        Optional<Trip> optionalTrip = tripRepository.findById(tripId);

        if (optionalUser.isEmpty()) {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("User ID not found")
                    .build();
        }

        if (optionalTrip.isEmpty()) {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Commuter ID not found")
                    .build();
        }

        Order order = new Order();
        updateOrderFromDTO(order, orderDTO);

        User user = optionalUser.get();
        order.setUser(user);

        Trip trip = optionalTrip.get();
        User commuter =trip.getUser();

        order.setCommuter(commuter);
        order.setTrip(trip);

        order.setOrderStatus(OrderStatus.NOT_ACTIVE);

        orderRepository.save(order);
        return CustomResponse.builder()
                .status(200) // Success status
                .message("Order saved and assigned successfully, waiting for the commuter to agree")
                .build();
    }

    //the userId in the params refer to user or commuter IDs (who make the cancle)
    public CustomResponse cancleOrder(Integer orderId, Integer cancelerId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {

            Order existingOrder = optionalOrder.get();
            OrderStatus orderStatus = existingOrder.getOrderStatus();

            //Who is the cancler
            Role cancler = null;

            //orderOwner
            User orderOwner = existingOrder.getUser();

            //This for who will cancle the order may be user or commuter
            User canclerUser = userRepository.findById(cancelerId).get();

            //This is for the commuter that delivers the order (commuter only)
            User commuter = existingOrder.getCommuter();

            User admin = userRepository.findById(1).get();

            if (canclerUser.equals(orderOwner)){
                cancler = Role.USER;
            } else if (canclerUser.equals(commuter)) {
                cancler = Role.COMMUTER;
            }

            //user amount
            Long orderOwnerAmount = orderOwner.getAmount();

            //Who carries the order
            Long commuterAmount = commuter.getAmount();

            Long adminAmount = admin.getAmount();

            Long orderPrice = (long)existingOrder.getExpectedPrice();

            //return full (not full pending comes after confirmed(treated like confirmed))
            if (orderStatus.equals(OrderStatus.PENDING)) {
                if (cancler.equals(Role.USER)){
                    orderOwnerAmount -= (orderPrice * 10 / 100);
                    commuterAmount += (orderPrice * 10 / 100);

                } else if (cancler.equals(Role.COMMUTER)) {
                    commuterAmount -= (orderPrice * 10 / 100);
                    orderOwnerAmount += (orderPrice * 10 / 100);
                }
            }
            // user pay 200 %
            // commuter pay 10%
            else if (orderStatus.equals(OrderStatus.IN_PROGRESS)) {
                Integer commuterCancledDelivers = 0;
                commuterCancledDelivers = commuter.getCancelDelivers();
                commuterCancledDelivers += 1;
                commuter.setCancelDelivers(commuterCancledDelivers);

                if (cancler.equals(Role.USER)){
                    System.out.println("in_progess");
                    orderOwnerAmount -= (orderPrice * 2);

                    //TODO : make a relation that said that the commuter have x money for order x to give it to him when he return the order
                    adminAmount +=(orderPrice * 2);
                } else if (cancler.equals(Role.COMMUTER)) {
                    commuterAmount -= (orderPrice * 10 / 100);

                    PromoCode promoCode = new PromoCode();
                    promoCode.setUser(orderOwner);
                    promocodeService.generatePromoCode(orderId);
                    promoCode.setPromocodeStatus(PromocodeStatus.ACTIVE);
                    promoCode.setDiscountAmount(orderPrice * 10 / 100);
                }
            }
            // The other will take 10%
            else if (orderStatus.equals(OrderStatus.CONFIRMED)) {
                if (cancler.equals(Role.USER)){
                    orderOwnerAmount -= (orderPrice * 10 / 100);
                    commuterAmount += (orderPrice * 10 / 100);
                } else if (cancler.equals(Role.COMMUTER)) {
                    commuterAmount -= (orderPrice * 10 / 100);
                    orderOwnerAmount += (orderPrice * 10 / 100);
                }
            }

            orderOwner.setAmount(orderOwnerAmount);
            commuter.setAmount(commuterAmount);
            admin.setAmount(adminAmount);
            existingOrder.setOrderStatus(OrderStatus.FAILED);
            userRepository.save(orderOwner);
            userRepository.save(commuter);
            userRepository.save(admin);
            orderRepository.save(existingOrder);

            return CustomResponse.builder()
                    .status(200)
                    .message("Order canceled successfully")
                    .build();

        }else return CustomResponse.builder()
                .status(404) // Not Found status
                .message("Order ID not found" )
                .build();
    }

    public CustomResponse findCommuterOrders(Integer commuterId) {
        Optional<User> optionalCommuter = userRepository.findById(commuterId);
        if (optionalCommuter.isPresent()){
            List<Order> orderList = orderRepository.findCommuterOrders(commuterId);
            return CustomResponse.builder()
                    .status(200)
                    .message("Order canceled successfully")
                    .data(orderList)
                    .build();
        }else return CustomResponse.builder()
                .status(404) // Not Found status
                .message("Commuter ID not found" )
                .build();
    }



    public CustomResponse negotiate(NegotiationDTO negotiationDTO) {
        Optional<Order> optionalOrder = orderRepository.findById(negotiationDTO.getOrderId());
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();
            existingOrder.setNegotiationPrice(negotiationDTO.getNewPrice());
            orderRepository.save(existingOrder);
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Negotiation successful. We will inform the customer about the new price and await their response.")
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order not found")
                    .build();
        }

    }

    public CustomResponse pickOrder(OrderPickDTO orderPickDTO) {
        Integer orderId = orderPickDTO.getOrderId();
        Integer commuterId = orderPickDTO.getCommuterId();
        double price = orderPickDTO.getApllicantPrice();

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        Optional<User> optionalCommuter = userRepository.findById(commuterId);

        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();

            if (optionalCommuter.isPresent()) {
                User existingCommuter = optionalCommuter.get();
                OrderApplicants orderApplicants = orderApplicantsRepository.findByOrderAndCommuter(existingOrder, existingCommuter);

                if (orderApplicants == null) {
                    OrderApplicants orderApplicant = new OrderApplicants();
                    orderApplicant.setCommuter(existingCommuter);
                    orderApplicant.setOrder(existingOrder);
                    orderApplicant.setApllicantPrice(price);

                    orderApplicantsRepository.save(orderApplicant);

                    return CustomResponse.builder()
                            .status(200) // Success status
                            .message("Order picked successfully. We will inform you when the user accepts.")
                            .build();
                } else {
                    return CustomResponse.builder()
                            .status(400) // Bad Request status
                            .message("You have already given an offer before. Please be patient until the user sees your order.")
                            .build();
                }
            } else {
                return CustomResponse.builder()
                        .status(404) // Not Found status
                        .message("Commuter does not exist")
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order does not exist")
                    .build();
        }
    }


    public CustomResponse getOrderApplicants(Integer orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();
            List<OrderApplicants> orderApplicationList = orderApplicantsRepository.findByOrder(existingOrder);
            List<ApplicantDTO> applicantDTOList = new ArrayList<>();
            for (OrderApplicants orderApplicant : orderApplicationList) {
                ApplicantDTO applicantDTO = new ApplicantDTO();
                applicantDTO.setFullName(orderApplicant.getCommuter().getFullName());
                applicantDTO.setPrice(orderApplicant.getApllicantPrice());
                applicantDTO.setCommuterPhotoURL(orderApplicant.getCommuter().getProfilePictureUrl());
                applicantDTO.setCommuterId(orderApplicant.getCommuter().getId());
                applicantDTOList.add(applicantDTO);
            }
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Applicants found for the order")
                    .data(applicantDTOList) // You can include relevant data
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order not found")
                    .build();
        }
    }


    public CustomResponse confirmPickingUp(ConfirmPickingUpDTO confirmPickingUpDTO) {
        double actualPrice = confirmPickingUpDTO.getPrice();
        double appPenefits = actualPrice * 7 / 100;
        double commuterMoney = actualPrice - appPenefits;
        Integer orderId = confirmPickingUpDTO.getOrderId();
        Integer commuterId = confirmPickingUpDTO.getCommuterId();

        // Retrieve the commuter
        Optional<User> optionalCommuter = userRepository.findById(commuterId);
        if (optionalCommuter.isEmpty()) {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Commuter not found")
                    .build();
        }
        User commuter = optionalCommuter.get();

        PaymentMethod paymentMethod = confirmPickingUpDTO.getPaymentMethod();
        String promoCode = confirmPickingUpDTO.getPromoCode();

        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order existingOrder = optionalOrder.get();
            User user = existingOrder.getUser();
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

                        return CustomResponse.builder()
                                .status(200) // Success status
                                .message("Order assigned successfully. Proceed to pick it up.")
                                .build();
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

                            return CustomResponse.builder()
                                    .status(200) // Success status
                                    .message("Order assigned successfully. Proceed to pick it up.")
                                    .build();
                        }
                    } else {
                        return CustomResponse.builder()
                                .status(400) // Bad Request status
                                .message("This promo code does not belong to this user or is not active.")
                                .build();
                    }
                }
            } else if (paymentMethod.equals(PaymentMethod.CASH)) {
                existingOrder.setCommuter(commuter);
                existingOrder.setOrderStatus(OrderStatus.PENDING);
                orderRepository.save(existingOrder);

                return CustomResponse.builder()
                        .status(200) // Success status
                        .message("Order assigned successfully. Proceed to pick it up.")
                        .build();
            }
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order not found")
                    .build();
        }

        return CustomResponse.builder()
                .status(404) // Not Found status
                .message("Error: Commuter or order not found.")
                .build();
    }

    public CustomResponse findById(Integer orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Order found")
                    .data(order)
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order not found")
                    .build();
        }
    }


    public CustomResponse declineOrder(Integer orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setCommuter(null);
            order.setTrip(null);
            orderRepository.save(order);
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Order Declined Successfully")
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order not found")
                    .build();
        }
    }


    @Transactional
    public CustomResponse confirmOrder(Integer orderId) {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setOrderStatus(OrderStatus.PENDING);
            Optional<User> optionalUser = userRepository.findById(order.getUser().getId());
            Optional<User> optionalAdmin = userRepository.findById(1);
            if (optionalUser.isPresent() && optionalAdmin.isPresent()){
                User user = optionalUser.get();
                User admin = optionalAdmin.get();
                Long userAmount = user.getAmount();
                Long adminAmount = admin.getAmount();
                Long orderPrice = (long) order.getExpectedPrice();
                userAmount = userAmount - orderPrice;
                adminAmount = adminAmount + orderPrice;
                user.setAmount(userAmount);
                admin.setAmount(adminAmount);
                userRepository.save(user);
                userRepository.save(admin);
            }
            orderRepository.save(order);
            return CustomResponse.builder()
                    .status(200) // Success status
                    .message("Order confirmed successfully, go and pick it up")
                    .build();
        } else {
            return CustomResponse.builder()
                    .status(404) // Not Found status
                    .message("Order not found")
                    .build();
        }
    }

    public CustomResponse deleteOrder(Integer orderId) {
        Optional<Order> orderOptional = orderRepository.findById(orderId);
        if (orderOptional.isPresent()){
            Order order = orderOptional.get();
            if (order.getOrderStatus().equals(OrderStatus.NOT_ACTIVE)){
                orderRepository.deleteById(orderId);
                return CustomResponse.builder().status(200).message("Order deleted successfully").build();
            }else return CustomResponse.builder().status(400).message("Order status must be not active to delete it.").build();
        }else return CustomResponse.builder().status(404).message("Order not found with id : " + orderId).build();
    }
}