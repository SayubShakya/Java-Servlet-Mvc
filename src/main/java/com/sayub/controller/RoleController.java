package com.sayub.controller;

import com.sayub.dto.request.CreateRoleRequest;
import com.sayub.dto.request.UpdateRoleRequest;
import com.sayub.dto.response.RoleResponse;
import com.sayub.entity.Role;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.RoleRepository;
import com.sayub.repository.impl.RoleRepositoryImpl;
import com.sayub.service.RoleService;
import com.sayub.service.impl.RoleServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/roles/*")
public class RoleController extends Controller {

    private RoleService roleService;
    private static final Logger log = Logger.getLogger(RoleController.class);

    @Override
    public void init() throws ServletException {
        log.info("RoleServlet init");
        RoleRepository roleRepository = new RoleRepositoryImpl();
        this.roleService = new RoleServiceImpl(roleRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();

            if (pathInfo == null || pathInfo.equals("/")) {
                getAllRoles(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                int id = extractIdFromPath(pathInfo.substring("/edit/".length()));
                editRole(request, response, id);
            } else if (pathInfo.startsWith("/delete/")) {
                deleteRole(request, response, pathInfo);
            } else {
                getRoleById(request, response, pathInfo);
            }
        });
    }

    private void getRoleById(HttpServletRequest request, HttpServletResponse response, String pathInfo) {
        int id = extractIdFromPath(pathInfo);
        Role role = roleService.getRoleById(id);

        request.setAttribute("role", new RoleResponse(role));
        view("roles", request, response);
    }

    private void deleteRole(HttpServletRequest request, HttpServletResponse response, String pathInfo) {
        int id = extractIdFromPath(pathInfo.substring("/delete/".length()));
        roleService.deleteRole(id);
        redirect(request, response, "roles");
    }

    private void editRole(HttpServletRequest request, HttpServletResponse response, int id) {
        Role role = roleService.getRoleById(id);

        UpdateRoleRequest updateRequest = new UpdateRoleRequest(
                role.getId(),
                role.getName()
        );

        request.setAttribute("role", updateRequest);
        view("updateRole", request, response);
    }

    private void getAllRoles(HttpServletRequest request, HttpServletResponse response) {
        List<RoleResponse> roleResponses = roleService.getAllRoles().stream()
                .map(RoleResponse::new)
                .collect(Collectors.toList());

        request.setAttribute("roles", roleResponses);
        view("roles", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();

            if (pathInfo != null && pathInfo.startsWith("/update/")) {
                int id = extractIdFromPath(pathInfo.substring("/update/".length()));
                String name = request.getParameter("name");

                UpdateRoleRequest updateRoleRequest = new UpdateRoleRequest(
                        id,
                        name
                );

                Role updatedRole = roleService.updateRole(id, updateRoleRequest);

                request.setAttribute("role", new RoleResponse(updatedRole));
                request.setAttribute("successMessage", "Role updated successfully");
                view("updateRole", request, response);
            } else {
                String name = request.getParameter("name");
                CreateRoleRequest createRequest = new CreateRoleRequest(name);
                Role createdRole = roleService.saveRole(createRequest);

                request.setAttribute("role", new RoleResponse(createdRole));
                request.setAttribute("successMessage", "Role created successfully");
                view("createRole", request, response);
            }
        });
    }

    private int extractIdFromPath(String pathInfo) {
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.trim().isEmpty()) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "Role ID is missing in the URL path.");
        }
        try {
            String idStr = pathInfo.startsWith("/") ? pathInfo.substring(1) : pathInfo;
            idStr = idStr.trim().replaceAll("/", "");
            return Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Role ID format in URL path: " + pathInfo);
        }
    }
}