package com.sayub.service;

import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.dto.request.UpdateUserRequest;
import com.sayub.entity.User;

import java.util.List;

public interface UserService {
    User updateUser(int id, UpdateUserRequest request);
    User getUserById(int id);
    List<User> getAllUsers();
    User deleteUser(int id);
}