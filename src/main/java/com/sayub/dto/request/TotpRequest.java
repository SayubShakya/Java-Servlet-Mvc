package com.sayub.dto.request;

public class TotpRequest {


    private String totp;
    private String email;

    public TotpRequest(String email, String totp) {
        this.email = email;
        this.totp = totp;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTotp() {
        return totp;
    }

    public void setTotp(String totp) {
        this.totp = totp;
    }
}
