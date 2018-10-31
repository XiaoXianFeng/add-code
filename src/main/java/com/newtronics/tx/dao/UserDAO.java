package com.newtronics.tx.dao;

import java.util.List;

import com.newtronics.tx.model.User;

public interface UserDAO {

    void insertUser(User user);

    User getUserByName(String username);

    List<User> getAllUsers();
}
