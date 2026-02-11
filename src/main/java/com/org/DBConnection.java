package com.org;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() throws SQLException {

        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String db   = System.getenv("DB_NAME");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASS");

        if (host == null || port == null || db == null) {
            throw new RuntimeException("Database environment variables not set");
        }

        String url =
            "jdbc:mysql://" + host + ":" + port + "/" + db +
            "?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }

        return DriverManager.getConnection(url, user, pass);
    }
}




//package com.org;
//
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//
//public class DBConnection {
//    private static final String URL = "jdbc:mysql://localhost:3306/smarthub";
//    private static final String USER = "root";
//    private static final String PASSWORD = "root";
//
//    public static Connection getConnection() throws SQLException {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver"); // load driver
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//        return DriverManager.getConnection(URL, USER, PASSWORD);
//    }
//}