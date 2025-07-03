package com.sayub.service;

import com.sayub.dto.request.LoginUserRequest;
import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.dto.request.TotpRequest;
import com.sayub.entity.User;

public interface AuthService {
    void register(RegisterUserRequest request);
    User login(LoginUserRequest request);
    User validateTotp(TotpRequest request);
}