package com.sayub.service;

import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.dto.request.UpdateUserRequest;
import com.sayub.entity.User;

import java.util.List;

public interface UserService {
    void updateUser(int id, UpdateUserRequest request);
    User getUserById(int id);
    List<User> getAllUsers();
    void deleteUser(int id);
}