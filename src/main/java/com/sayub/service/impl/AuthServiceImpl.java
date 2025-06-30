package com.sayub.service.impl;

import com.sayub.dto.request.LoginUserRequest;
import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.dto.request.TotpRequest;
import com.sayub.entity.User;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.UserRepository;
import com.sayub.service.AuthService;
import com.sayub.util.TOTPUtil;

public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;

    public AuthServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public void register(RegisterUserRequest request) {
        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
            throw new ApplicationException(409, "User with email " + request.getEmail() + " already exists.");
        }

        if (!TOTPUtil.verifyCode(request.getSecretKey(), request.getTotpCode())) {
            throw new ApplicationException(409, "Invalid TOTP Code");
        }

        User user = new User();
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setPhoneNumber(request.getPhoneNumber());
        user.setEmail(request.getEmail());
        user.setPassword(request.getPassword());
        user.setTotpSecretKey(request.getSecretKey());
        user.setActive(true);

        userRepository.save(user);
    }

    @Override
    public void login(LoginUserRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ApplicationException(409, "Username/Password is not correct"));

        if (!user.getPassword().equals(request.getPassword())) {
            throw new ApplicationException(409, "Username/Password is not correct");
        }
    }

    @Override
    public void validateTotp(TotpRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ApplicationException(409, "Username/Password is not correct"));

        if (!TOTPUtil.verifyCode(user.getTotpSecretKey(), request.getTotp())) {
            throw new ApplicationException(409, "Your OTP is not correct.");
        }
    }
}
