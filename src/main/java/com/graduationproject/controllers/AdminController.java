package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
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


@CrossOrigin
@RestController
@RequestMapping("api/v1/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminService adminService;

    @GetMapping("users")
    public CustomResponse findUsersByRole(@RequestParam Role role, @RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findUsersByRole(role, pageNum, pageSize);
    }

    @GetMapping("orders")
    public CustomResponse findAllOrders(@RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findAllOrders(pageNum, pageSize);
    }

    @GetMapping("count")
    public CustomResponse countAll() {
        return adminService.countAll();
    }

    @GetMapping("count-all-orders")
    public CustomResponse countOrdersByStatus() {
        return adminService.countOrdersByStatus();
    }

}