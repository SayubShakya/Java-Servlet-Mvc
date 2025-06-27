package com.sayub.service;

import com.sayub.dto.request.LoginUserRequest;
import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.dto.request.TotpRequest;

public interface AuthService {
    void register(RegisterUserRequest request);

    void login(LoginUserRequest request);

    void validateTotp(TotpRequest request);
}