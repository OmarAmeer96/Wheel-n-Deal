package com.graduationproject.controllers;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.GetAllOrders;
import com.graduationproject.DTOs.GetOrdersDTO;
import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.OrderStatus;
import com.graduationproject.entities.Role;
import com.graduationproject.services.impl.AdminService;
import com.graduationproject.services.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminService adminService;

    @GetMapping("users")
    public CustomResponse findUsersByRole(@RequestParam Role role, @RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findUsersByRole(role, pageNum, pageSize);
    }
    @GetMapping("users/count")
    public CustomResponse countUsersByRole(@RequestParam Role role) {
        return adminService.countUsersByRole(role);
    }

    @GetMapping("orders")
    public CustomResponse findAllOrders(@RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findAllOrders(pageNum, pageSize);
    }

    @GetMapping("orders/based-on-status")
    public CustomResponse findOrdersByOrderStatus(@RequestParam OrderStatus orderStatus, @RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findOrdersByOrderStatus(orderStatus, pageNum, pageSize);
    }

    @GetMapping("orders/count")
    public CustomResponse countOrdersByStatus(@RequestParam OrderStatus orderStatus) {
        return adminService.countOrdersByStatus(orderStatus);
    }

}