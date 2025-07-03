package com.sayub.service;

import com.sayub.dto.request.CreateRoleRequest;
import com.sayub.dto.request.UpdateRoleRequest;
import com.sayub.entity.Role;

import java.util.List;

public interface RoleService {
    Role saveRole(CreateRoleRequest request);
    Role updateRole(int id, UpdateRoleRequest request);
    Role getRoleById(int id);
    List<Role> getAllRoles();
    Role deleteRole(int id);
}