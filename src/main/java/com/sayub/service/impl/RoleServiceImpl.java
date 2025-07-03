package com.sayub.service.impl;

import com.sayub.dto.request.CreateRoleRequest;
import com.sayub.dto.request.UpdateRoleRequest;
import com.sayub.entity.Role;
import com.sayub.exception.ApplicationException;
import com.sayub.repository.RoleRepository;
import com.sayub.service.RoleService;

import java.util.List;

public class RoleServiceImpl implements RoleService {
    private final RoleRepository roleRepository;

    public RoleServiceImpl(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public Role saveRole(CreateRoleRequest request) {
        if (request.getName() == null || request.getName().trim().isEmpty()) {
            throw new ApplicationException(400, "Role name cannot be empty");
        }

        Role role = new Role();
        role.setName(request.getName());
        return roleRepository.save(role);
    }

    @Override
    public Role updateRole(int id, UpdateRoleRequest request) {
        if (request.getName() == null || request.getName().trim().isEmpty()) {
            throw new ApplicationException(400, "Role name cannot be empty");
        }

        Role existingRole = getRoleById(id);
        existingRole.setName(request.getName());
        roleRepository.update(existingRole);
        return existingRole;
    }

    @Override
    public Role getRoleById(int id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new ApplicationException(404, "Role with ID " + id + " not found."));
    }

    @Override
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    @Override
    public Role deleteRole(int id) {
        Role role = getRoleById(id);
        roleRepository.deleteById(id);
        return role;
    }
}