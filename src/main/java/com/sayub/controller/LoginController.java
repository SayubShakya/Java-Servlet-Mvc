package com.sayub.controller;

import com.sayub.dto.request.LoginUserRequest;
import com.sayub.entity.User;
import com.sayub.repository.UserRepository;
import com.sayub.repository.impl.UserRepositoryImpl;
import com.sayub.service.AuthService;
import com.sayub.service.impl.AuthServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.log4j.Logger;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends Controller {
    private AuthService authService;
    private UserRepository userRepository;
    private static final Logger log = Logger.getLogger(LoginController.class);

    @Override
    public void init() throws ServletException {
        this.userRepository = new UserRepositoryImpl();
        this.authService = new AuthServiceImpl(userRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            view("common/login", request, response);
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            authService.login(new LoginUserRequest(email, password));

            User user = userRepository.findByEmail(email)
                    .orElseThrow(() -> new RuntimeException("User not found"));

            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("currentUser", user);

            redirect(request, response, "dashboard");
        });
    }
}