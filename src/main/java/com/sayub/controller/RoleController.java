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
                List<RoleResponse> roleResponses = roleService.getAllRoles().stream()
                        .map(RoleResponse::new)
                        .collect(Collectors.toList());
                request.setAttribute("roles", roleResponses);
                view("roles", request, response);

            } else if (pathInfo.startsWith("/delete/")) {
                int id = extractIdFromPath(pathInfo.substring("/delete".length()));
                Role deletedRole = roleService.deleteRole(id);
                request.setAttribute("role", new RoleResponse(deletedRole));
                view("deleteRole", request, response);

            } else if (pathInfo.startsWith("/update/")) {
                int id = extractIdFromPath(pathInfo.substring("/update".length()));
                Role role = roleService.getRoleById(id);
                UpdateRoleRequest updateRequest = new UpdateRoleRequest(role.getId(), role.getName());
                request.setAttribute("role", updateRequest);
                view("updateRole", request, response);

            } else {
                int id = extractIdFromPath(pathInfo);
                Role role = roleService.getRoleById(id);
                request.setAttribute("role", new RoleResponse(role));
                view("roles", request, response);
            }
        });
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();
            String name = request.getParameter("name");

            if (name == null || name.trim().isEmpty()) {
                throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                        "Role name is required");
            }

            if (pathInfo != null && pathInfo.startsWith("/update/")) {
                int id = extractIdFromPath(pathInfo.substring("/update".length()));
                UpdateRoleRequest updateRoleRequest = new UpdateRoleRequest(id, name);
                Role updatedRole = roleService.updateRole(id, updateRoleRequest);

                request.setAttribute("role", new RoleResponse(updatedRole));
                request.setAttribute("successMessage", "Role updated successfully");
                view("updateRole", request, response);
            } else {
                CreateRoleRequest createRequest = new CreateRoleRequest(name);
                Role createdRole = roleService.saveRole(createRequest);

                request.setAttribute("role", new RoleResponse(createdRole));
                request.setAttribute("successMessage", "Role created successfully");
                view("createRole", request, response);
            }
        });
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            String pathInfo = request.getPathInfo();
            int id = extractIdFromPath(pathInfo);
            Role deletedRole = roleService.deleteRole(id);
            request.setAttribute("role", new RoleResponse(deletedRole));
            view("deleteRole", request, response);
        });
    }

    private int extractIdFromPath(String pathInfo) {
        if (pathInfo == null || pathInfo.equals("/")) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "Role ID is missing in the URL path.");
        }
        try {
            String idStr = pathInfo.replaceAll("^/+", "").split("/")[0];
            return Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            throw new ApplicationException(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid Role ID format in URL path: " + pathInfo);
        }
    }
}