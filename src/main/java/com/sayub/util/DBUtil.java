package com.sayub.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	// JDBC
	private static final String URL = "jdbc:mysql://localhost:3306/login_register_crud_app";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "9828807288";
	static {
		try {
			// Load the MySQL JDBC driver
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {

		System.out.println("Connect build vaira xa");
		return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}
}