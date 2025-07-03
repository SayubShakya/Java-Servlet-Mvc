package com.sayub.dto.request;

public class CreateRoleRequest {
    private String name;

    public CreateRoleRequest(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}