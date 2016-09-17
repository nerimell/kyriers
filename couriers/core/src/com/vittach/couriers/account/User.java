package com.vittach.couriers.account;

public class User {
    private int id=-1;
    private int number;

    private String pin;
    private String mail;
    private String userName;
    private String password;

    public int getId() {
        return id;
    }

    public String getPin() {
        return pin;
    }

    public int getNumber() {
        return number;
    }

    public String getMail(){
        return mail;
    }

    public String getUserName(){
        return userName;
    }

    public void setId(int uid) {
        this.id = uid;
    }

    public String getPassword() {
        return password;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public
    void setUserName(String userName) {
        this.userName = userName;
    }

    public void setMail(String email) {
        this.mail = email;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
