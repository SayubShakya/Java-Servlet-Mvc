package com.sayub.service.impl;

import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.dto.request.UpdateUserRequest;
import com.sayub.entity.User;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.UserRepository;
import com.sayub.service.UserService;
import com.sayub.util.TOTPUtil;

import java.util.List;

public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public void updateUser(int id, UpdateUserRequest request) {
        User existingUser = getUserById(id);

        existingUser.setFirstName(request.getFirstName());
        existingUser.setLastName(request.getLastName());
        existingUser.setPhoneNumber(request.getPhoneNumber());
        existingUser.setEmail(request.getEmail());
        if (request.getPassword() != null && !request.getPassword().isEmpty()) {
            existingUser.setPassword(request.getPassword());
        }

        userRepository.update(existingUser);
    }

    @Override
    public User getUserById(int id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ApplicationException(404, "User with ID " + id + " not found."));
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public void deleteUser(int id) {
        getUserById(id);
        userRepository.deleteById(id);
    }
}