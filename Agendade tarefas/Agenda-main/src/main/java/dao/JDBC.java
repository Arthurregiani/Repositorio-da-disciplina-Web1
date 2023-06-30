package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/tarefas";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "root";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Error loading database driver", e);
        }
    }

    private JDBC() {}

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
    }
}
