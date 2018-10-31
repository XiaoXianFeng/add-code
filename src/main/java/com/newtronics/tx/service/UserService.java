package com.newtronics.tx.service;

import java.util.List;

import com.newtronics.tx.model.User;

public interface UserService {

    void insertUser(User user);

    User getUserByName(String username);

    List<User> getAllUsers();
}
