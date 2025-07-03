package com.sayub.controller;

import com.sayub.dto.request.RegisterUserRequest;
import com.sayub.entity.Role;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.RoleRepository;
import com.sayub.repository.UserRepository;
import com.sayub.repository.impl.RoleRepositoryImpl;
import com.sayub.repository.impl.UserRepositoryImpl;
import com.sayub.service.AuthService;
import com.sayub.service.RoleService;
import com.sayub.service.impl.AuthServiceImpl;
import com.sayub.service.impl.RoleServiceImpl;
import com.sayub.util.TOTPUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.util.List;

@WebServlet("/register")
public class RegisterController extends Controller {
    private AuthService authService;
    private RoleService roleService;
    private static final Logger log = Logger.getLogger(RegisterController.class);

    @Override
    public void init() throws ServletException {
        UserRepository userRepository = new UserRepositoryImpl();
        RoleRepository roleRepository = new RoleRepositoryImpl();
        this.authService = new AuthServiceImpl(userRepository);
        this.roleService = new RoleServiceImpl(roleRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String secretKey = TOTPUtil.generateSecretKey();
            List<Role> roles = roleService.getAllRoles();
            request.setAttribute("roles", roles);

            String qrUrl = TOTPUtil.getQRBarcodeURL(secretKey, "TEST", "TEST");
            String base64QR = null;
            try {
                base64QR = TOTPUtil.getQRCodeImageBase64(qrUrl, 300, 300);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("qr", base64QR);
            request.setAttribute("secretKey", secretKey);
            view("register", request, response);
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNo = request.getParameter("phoneNo");
            String secretKey = request.getParameter("secretKey");
            String totpCode = request.getParameter("totpCode");
            int roleId = Integer.parseInt(request.getParameter("roleId"));

            authService.register(new RegisterUserRequest(
                    firstName, lastName, phoneNo, email,
                    password, secretKey, totpCode, roleId));
            view("login", request, response);
        });
    }
}