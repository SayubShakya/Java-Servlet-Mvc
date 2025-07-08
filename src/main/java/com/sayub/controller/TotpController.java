package com.sayub.controller;

import com.sayub.dto.request.TotpRequest;
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

@WebServlet("/totp")
public class TotpController extends Controller {

    private AuthService authService;
    private static final Logger log = Logger.getLogger(TotpController.class);

    @Override
    public void init() throws ServletException {
        UserRepository userRepository = new UserRepositoryImpl();
        this.authService = new AuthServiceImpl(userRepository);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            try {
                view("totp", request, response);
            } catch (Exception e) {
                log.error("Exception: ", e);
            }
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        handleResponse(request, response, () -> {

            String email = request.getParameter("email");
            String totp = request.getParameter("totp");

            User user = authService.validateTotp(new TotpRequest(email, totp));

            HttpSession session = request.getSession();

            session.setAttribute("currentUser", user);

            redirect(request, response, "dashboard");
        });
    }
}
