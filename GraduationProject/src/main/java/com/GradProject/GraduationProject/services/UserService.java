package com.GraduationProject.test.services;

import com.GraduationProject.test.DTOs.LoginDTO;
import com.GraduationProject.test.DTOs.UserDTO;
import com.GraduationProject.test.entities.AppUser;
import com.GraduationProject.test.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class UserService{
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder encoder;

    public String addUser(UserDTO userDTO) {
        AppUser appUser = new AppUser(
                userDTO.getId(),
                userDTO.getName(),
                this.encoder.encode(userDTO.getPassword()),
                userDTO.getPhoneNumber()
        );
        userRepository.save(appUser);
        return appUser.getName();
    }

    public String  loginUser(LoginDTO loginDTO) {
        String msg = "";
        AppUser user1 = UserRepository.getByName(loginDTO.getName());
        if (user1 != null) {
            String password = loginDTO.getPassword();
            String encodedPassword = user1.getPassword();
            Boolean isPwdRight = encoder.matches(password, encodedPassword);
            if (isPwdRight) {
                Optional<AppUser> user = UserRepository.getOneByNameAndPassword(loginDTO.getName(), encodedPassword);
                if (user.isPresent()) {
                    return "Login Success";
                } else {
                    return "Login Failed";
                }
            } else {
                return "Password Not Match";
            }
        }else {
            return "Name Not Exits";
        }
    }
}
