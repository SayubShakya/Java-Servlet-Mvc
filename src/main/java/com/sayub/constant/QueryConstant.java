package com.sayub.constant;

public interface QueryConstant {
    interface Users {
        String SAVE = "INSERT INTO users (first_name, last_name, phone_number, email, password, role_id, is_active, totp_secret_key) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String UPDATE = "UPDATE users SET first_name = ?, last_name = ?, phone_number = ?, email = ?, password = ?, role_id = ? WHERE id = ? AND is_active = 1";
        String FIND_BY_ID = "SELECT * FROM users WHERE id = ? AND is_active = 1";
        String FIND_ALL = "SELECT * FROM users WHERE is_active = 1 ORDER BY id";
        String DELETE_BY_ID = "UPDATE users SET is_active = 0 WHERE id = ? AND is_active = 1";
        String FIND_BY_EMAIL = "SELECT * FROM users WHERE email = ? AND is_active = 1";
    }

    interface Roles {
        String SAVE = "INSERT INTO roles(name) VALUES (?)";
        String UPDATE = "UPDATE roles SET name = ? WHERE id = ? AND is_active = 1";
        String FIND_BY_ID = "SELECT * FROM roles WHERE id = ? AND is_active = 1";
        String FIND_ALL = "SELECT * FROM roles WHERE is_active = 1 ORDER BY id";
        String DELETE_BY_ID = "UPDATE roles SET is_active = 0 WHERE id = ? AND is_active = 1";
    }
}