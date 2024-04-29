package com.graduationproject.services.impl;

import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.DTOs.UserDTO;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.OrderRepository;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    @Override
    public UserDetailsService userDetailsService(){
        return new UserDetailsService() {
            @Override
            public UserDetails loadUserByUsername(String username) {
                return userRepository.findByUsername(username)
                        .orElseThrow(() -> new UsernameNotFoundException("User Not Found "));
            }
        };
    }

    public CustomResponse deleteById(Integer id) {
        try {
            userRepository.deleteById(id);
            return CustomResponse.builder()
                    .status(HttpStatus.OK.value())
                    .message("User deleted successfully")
                    .build();
        } catch (EmptyResultDataAccessException e) {
            return CustomResponse.builder()
                    .status(HttpStatus.NOT_FOUND.value())
                    .message("User not found with ID: " + id)
                    .build();
        } catch (Exception e) {
            return CustomResponse.builder()
                    .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                    .message("An error occurred while deleting the user")
                    .build();
        }
    }
    public List<UserDTO> findUsersByRole(Role role) {
        return userRepository.findUsersByRole(role);
    }
    public long countUsersByRole(Role role) {
        return userRepository.countUsersByRole(role);
    }


}