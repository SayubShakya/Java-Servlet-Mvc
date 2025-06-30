package com.sayub.controller;

import com.sayub.dto.request.LoginUserRequest;
import com.sayub.entity.User;
import com.sayub.repository.UserRepository;
import com.sayub.repository.impl.UserRepositoryImpl;
import com.sayub.service.AuthService;
import com.sayub.service.impl.AuthServiceImpl;
import com.sayub.util.TOTPUtil;  // Your existing util
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends Controller {

    private AuthService authService;
    private UserRepository userRepository;  // To fetch user info
    private static final Logger log = Logger.getLogger(LoginController.class);

    @Override
    public void init() throws ServletException {
        this.userRepository = new UserRepositoryImpl();
        this.authService = new AuthServiceImpl(userRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            try {
                view("login", request, response);
            } catch (Exception e) {
                log.error("Exception: ", e);
            }
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        handleResponse(request, response, () -> {

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            authService.login(new LoginUserRequest(email, password));

            User user = userRepository.findByEmail(email)
                    .orElseThrow(() -> new RuntimeException("User not found"));

            String otpCode = TOTPUtil.getTOTPCode(user.getTotpSecretKey());
            System.out.println("Generated OTP for user " + email + ": " + otpCode);

            request.setAttribute("email", email);
            view("totp", request, response);
        });
    }
}
