package com.graduationproject.services.impl;

import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    public Page<UserDTO> findUsersByRole(Role role, Integer pageNum, Integer pageSize) {
        Pageable page = PageRequest.of(pageNum, pageSize, Sort.by("id"));
        return userRepository.findUsersByRole(role, page);
    }
    public long countUsersByRole(Role role) {
        return userRepository.countUsersByRole(role);
    }

}
