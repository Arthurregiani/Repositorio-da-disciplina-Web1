package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;

public class UserDAO {
    private Connection connection;

    public UserDAO() throws SQLException {
        connection = JDBC.getConnection();
    }

    public boolean isUserExists(String username, String email) {
        String query = "SELECT COUNT(*) FROM usuarios WHERE login = ? OR email = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public void insertUser(User user) {
        String query = "INSERT INTO usuarios (login, senha, nome, email) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, user.getLogin());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getUsername());
            statement.setString(4, user.getEmail());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean isValidUser(String username, String password) {
        boolean isValid = false;
        String query = "SELECT senha FROM usuarios WHERE login = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String storedPassword = resultSet.getString("senha");
                    isValid = password.equals(storedPassword);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isValid;
    }
    
    public static int getUserIdByUsername(String username) {
        int userId = 0;
        String query = "SELECT id FROM usuarios WHERE login = ?";

        try (Connection connection = JDBC.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                userId = resultSet.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }

}