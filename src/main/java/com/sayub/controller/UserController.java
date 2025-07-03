package com.sayub.controller;

import com.sayub.dto.request.UpdateUserRequest;
import com.sayub.dto.response.UserResponse;
import com.sayub.entity.User;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.UserRepository;
import com.sayub.repository.impl.UserRepositoryImpl;
import com.sayub.service.UserService;
import com.sayub.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/users/*")
public class UserController extends Controller {

    private UserService userService;
    private static final Logger log = Logger.getLogger(UserController.class);

    @Override
    public void init() throws ServletException {
        log.info("UserServlet init");
        UserRepository userRepository = new UserRepositoryImpl();
        this.userService = new UserServiceImpl(userRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();

            if (pathInfo == null || pathInfo.equals("/")) {
                List<UserResponse> userResponses = userService.getAllUsers().stream()
                        .map(UserResponse::new)
                        .collect(Collectors.toList());

                request.setAttribute("users", userResponses);
                view("users", request, response);

            } else if (pathInfo.startsWith("/delete/")) {
                int id = extractIdFromPath(pathInfo.substring("/delete".length()));
                User deletedUser = userService.deleteUser(id);

                request.setAttribute("user", new UserResponse(deletedUser));
                view("deleteUser", request, response);

            } else if (pathInfo != null && pathInfo.startsWith("/update/")) {
                int id = extractIdFromPath(pathInfo.substring("/update".length()));
                User user = userService.getUserById(id);

                UpdateUserRequest updateRequest = new UpdateUserRequest(
                        user.getId(),
                        user.getEmail(),
                        user.getFirstName(),
                        user.getLastName(),
                        user.getPhoneNumber()
                );

                request.setAttribute("user", updateRequest);
                view("updateUser", request, response);

            } else {
                int id = extractIdFromPath(pathInfo);
                User user = userService.getUserById(id);

                request.setAttribute("user", new UserResponse(user));
                view("users", request, response);
            }
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();

            if (pathInfo != null && pathInfo.startsWith("/update/")) {
                int id = extractIdFromPath(pathInfo.substring("/update".length()));

                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String phoneNumber = request.getParameter("phoneNumber");
                String email = request.getParameter("email");
                UpdateUserRequest updateUserRequest = new UpdateUserRequest(
                        id,
                        email,
                        firstName,
                        lastName,
                        phoneNumber
                );

                User updatedUser = userService.updateUser(id, updateUserRequest);

                request.setAttribute("user", new UserResponse(updatedUser));
                request.setAttribute("successMessage", "User updated successfully");
                view("updateUser", request, response);
            }
        });
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();
            int id = extractIdFromPath(pathInfo);

            User deletedUser = userService.deleteUser(id);

            request.setAttribute("user", new UserResponse(deletedUser));
            view("deleteUser", request, response);
        });
    }

    private int extractIdFromPath(String pathInfo) {
        if (pathInfo == null || pathInfo.equals("/")) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "User ID is missing in the URL path.");
        }
        try {
            String idStr = pathInfo.startsWith("/") ? pathInfo.substring(1) : pathInfo;
            return Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid User ID format in URL path: " + pathInfo);
        }
    }
}