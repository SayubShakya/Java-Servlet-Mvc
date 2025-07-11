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
        this.userService = new UserServiceImpl(new UserRepositoryImpl());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();

            if (pathInfo == null || pathInfo.equals("/")) {
                getAllUsers(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                editUser(request, response, extractIdFromPath(pathInfo.substring(6)));
            } else if (pathInfo.startsWith("/delete/")) {
                deleteUser(request, response, extractIdFromPath(pathInfo.substring(8)));
            } else {
                getUserById(request, response, extractIdFromPath(pathInfo));
            }
        });
    }

    private void getUserById(HttpServletRequest request, HttpServletResponse response, int id) {
        User user = userService.getUserById(id);
        request.setAttribute("user", new UserResponse(user));
        view("admin/users", request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response, int id) {
        userService.deleteUser(id);
        redirect(request, response, "users");
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response, int id) {
        User user = userService.getUserById(id);
        request.setAttribute("user", new UpdateUserRequest(
                user.getId(),
                user.getEmail(),
                user.getFirstName(),
                user.getLastName(),
                user.getPhoneNumber()
        ));
        view("common/updateUser", request, response);
    }

    private void getAllUsers(HttpServletRequest request, HttpServletResponse response) {
        List<UserResponse> users = userService.getAllUsers().stream()
                .map(UserResponse::new)
                .collect(Collectors.toList());
        request.setAttribute("users", users);
        view("admin/users", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            if (request.getPathInfo().startsWith("/update/")) {
                int id = extractIdFromPath(request.getPathInfo().substring(8));
                User updatedUser = userService.updateUser(id, new UpdateUserRequest(
                        id,
                        request.getParameter("email"),
                        request.getParameter("firstName"),
                        request.getParameter("lastName"),
                        request.getParameter("phoneNumber")
                ));

                request.setAttribute("user", new UserResponse(updatedUser));
                request.setAttribute("successMessage", "User updated successfully");
                view("common/updateUser", request, response);
            }
        });
    }

    private int extractIdFromPath(String pathInfo) {
        if (pathInfo == null || pathInfo.trim().isEmpty()) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "User ID is missing in URL path");
        }
        try {
            return Integer.parseInt(pathInfo.replaceAll("/", "").trim());
        } catch (NumberFormatException e) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid User ID format: " + pathInfo);
        }
    }
}