package com.sayub.controller;

import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.UserRepository;
import com.sayub.repository.impl.UserRepositoryImpl;
import com.sayub.service.AuthService;
import com.sayub.service.impl.AuthServiceImpl;
import com.sayub.util.TOTPUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends Controller {

    private AuthService authService;
    private static final Logger log = Logger.getLogger(RegisterController.class);

    @Override
    public void init() throws ServletException {
        UserRepository userRepository = new UserRepositoryImpl();
        this.authService = new AuthServiceImpl(userRepository);
    }

    public void handleResponse(HttpServletRequest request, HttpServletResponse response, Runnable task) {
        try {
            task.run();
        } catch (ApplicationException e) {
            log.error("ApplicationException: ", e);
            view("500", request, response);
        } catch (Exception e) {
            log.error("Exception: ", e);
            view("500", request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String secretKey = TOTPUtil.generateSecretKey();
            System.out.println("Secret Key: " + secretKey);

            String qrUrl = TOTPUtil.getQRBarcodeURL(secretKey, "TEST", "TEST");
            try {
                String base64QR = TOTPUtil.getQRCodeImageBase64(qrUrl, 300, 300);
                request.setAttribute("qr", base64QR);
                request.setAttribute("secretKey", secretKey);
                view("register", request, response);
                ;
            } catch (Exception e) {
                log.error("Exception: ", e);
            }
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        handleResponse(request, response, () -> {

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNo = request.getParameter("phoneNo");
            String secretKey = request.getParameter("secretKey");
            String totpCode = request.getParameter("totpCode");

            authService.register(new RegisterUserRequest(firstName, lastName, phoneNo, email, password, secretKey, totpCode));
            view("login", request, response);
        });
    }
}
