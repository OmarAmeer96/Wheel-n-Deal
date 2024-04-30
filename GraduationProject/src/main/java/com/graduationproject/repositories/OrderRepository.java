package com.graduationproject.repositories;

import com.graduationproject.DTOs.GetOrdersDTO;
import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.Order;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order,Integer> {

    List<Order> findByFromAndTo(String from, String to);

    @Query("SELECT o FROM Order o WHERE o.user.id = :userId")
    List<Order> findAllByUserId(@Param("userId") Integer userId);

    @Query(value = "SELECT * FROM orders WHERE user_id = :userId AND order_status = 'NOT_ACTIVE'", nativeQuery = true)
    List<Order> findNotActiveOrders(@Param("userId") Integer userId);


    @Query(value = "SELECT * FROM orders WHERE commuter_id = :commuterId AND order_status != 'NOT_ACTIVE'", nativeQuery = true)
    List<Order> findCommuterOrders(@Param("commuterId") Integer commuterId);

    @Query("SELECT new com.graduationproject.DTOs.GetOrdersDTO(o.Id, o.orderName, o.countOfOrders, o.breakable, o.expiryDate, o.expectedPrice, o.orderPhotoUrl, o.from, o.to, o.SenderPhoneNumber, o.ReceiverPhoneNumber) FROM Order o WHERE o.orderStatus = :orderStatus")
    Page<GetOrdersDTO> findOrdersByOrderStatus(@Param("orderStatus") OrderStatus orderStatus, Pageable pageable);

}