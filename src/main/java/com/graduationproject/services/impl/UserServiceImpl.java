package com.graduationproject.services.impl;

import com.graduationproject.DTOs.AddressDTO;
import com.graduationproject.DTOs.CustomResponse;
import com.graduationproject.entities.Address;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.AddressRepository;
import com.graduationproject.repositories.UserRepository;
import com.graduationproject.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final AddressRepository addressRepository;
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


    public CustomResponse addAddress(Integer userId, AddressDTO addressDTO) {
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalUser.isPresent()){
            User user = optionalUser.get();
            Address address = new Address();
            address.setUser(user);
            address.setAddressName(addressDTO.getAddressName());
            address.setAddress(address.getAddress());
            addressRepository.save(address);
            return CustomResponse.builder().status(201).message("Address Added Successfully").build();
        }else return CustomResponse.builder()
                .status(HttpStatus.NOT_FOUND.value())
                .message("User not found")
                .build();
    }

    public CustomResponse getAllAddressesResponseForUser(Integer userId) {
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalUser.isPresent()){
            User user = optionalUser.get();
            List<Address> addressList = user.getAddressList();
            return CustomResponse.builder().status(201).message("Address Retrieved Successfully").data(addressList).build();
        }else return CustomResponse.builder()
                .status(HttpStatus.NOT_FOUND.value())
                .message("User not found")
                .build();
    }
}