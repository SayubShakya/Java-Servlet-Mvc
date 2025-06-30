package com.sayub.service.impl;

import com.sayub.dto.request.UpdateUserRequest;
import com.sayub.entity.User;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.UserRepository;
import com.sayub.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User updateUser(int id, UpdateUserRequest request) {
        User existingUser = getUserById(id);

        existingUser.setFirstName(request.getFirstName());
        existingUser.setLastName(request.getLastName());
        existingUser.setPhoneNumber(request.getPhoneNumber());
        existingUser.setEmail(request.getEmail());

        userRepository.update(existingUser);
        return existingUser;
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
    public User deleteUser(int id) {
        User user = getUserById(id);
        userRepository.deleteById(id);
        return user;
    }

}