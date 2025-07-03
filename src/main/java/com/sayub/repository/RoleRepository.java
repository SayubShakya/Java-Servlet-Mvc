package com.sayub.repository;

import com.sayub.entity.Role;

import java.util.List;
import java.util.Optional;

public interface RoleRepository {
    Role save(Role role);
    void update(Role role);
    Optional<Role> findById(int id);
    List<Role> findAll();
    void deleteById(int id);
}
