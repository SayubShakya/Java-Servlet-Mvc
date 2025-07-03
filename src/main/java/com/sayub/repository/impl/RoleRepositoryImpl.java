package com.sayub.repository.impl;

import com.sayub.constant.QueryConstant.Roles;
import com.sayub.db.DatabaseConnector;
import com.sayub.db.query.RowMapper;
import com.sayub.entity.Role;
import com.sayub.repository.RoleRepository;

import java.util.List;
import java.util.Optional;

public class RoleRepositoryImpl implements RoleRepository {
    private static final RowMapper<Role> ROLE_ROW_MAPPER = rs -> {
        Role role = new Role();
        role.setId(rs.getInt("id"));
        role.setName(rs.getString("name"));
        return role;
    };

    @Override
    public Role save(Role role) {
        int generatedId = DatabaseConnector.updateWithGeneratedKeys(Roles.SAVE, role.getName());
        role.setId(generatedId);
        return role;
    }

    @Override
    public void update(Role role) {
        DatabaseConnector.update(Roles.UPDATE, role.getName(), role.getId());
    }

    @Override
    public Optional<Role> findById(int id) {
        return DatabaseConnector.queryOne(Roles.FIND_BY_ID, ROLE_ROW_MAPPER, id);
    }

    @Override
    public List<Role> findAll() {
        return DatabaseConnector.queryList(Roles.FIND_ALL, ROLE_ROW_MAPPER);
    }

    @Override
    public void deleteById(int id) {
        DatabaseConnector.update(Roles.DELETE_BY_ID, id);
    }
}