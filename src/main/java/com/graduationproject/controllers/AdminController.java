package com.graduationproject.controllers;

import com.graduationproject.DTOs.*;
import com.graduationproject.services.impl.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@CrossOrigin
@RestController
@RequestMapping("api/v1/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminService adminService;

    @GetMapping("users")
    public CustomResponse findUsersByRole(@RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findUsersByRole(pageNum, pageSize);
    }

    @GetMapping("orders")
    public CustomResponse findAllOrders(@RequestParam Integer pageNum, @RequestParam Integer pageSize) {
        return adminService.findAllOrders(pageNum, pageSize);
    }

    @GetMapping("count-all")
    public CustomResponse countAll() {
        return adminService.countAll();
    }

    @GetMapping("orders-created-last-week")
    public List<OrderCountDTO> getOrdersCreatedLastWeek() {
        return adminService.getOrdersCreatedLastWeek();
    }

    @GetMapping("users-created-last-week")
    public List<UserCountDTO> getUsersCreatedLastWeek() {
        return adminService.getUsersCreatedLastWeek();
    }
}