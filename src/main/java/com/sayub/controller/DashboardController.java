package com.sayub.controller;

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

@WebServlet("/dashboard")
public class DashboardController extends Controller {

    private AuthService authService;
    private static final Logger log = Logger.getLogger(DashboardController.class);

    @Override
    public void init() throws ServletException {
        UserRepository userRepository = new UserRepositoryImpl();
        this.authService = new AuthServiceImpl(userRepository);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            try {
                HttpSession session = request.getSession(false);
                String email = (String) session.getAttribute("email");
                request.setAttribute("email", email);
                view("dashboard", request, response);
            } catch (Exception e) {
                log.error("Exception: ", e);
            }
        });
    }
}
