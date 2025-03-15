package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Users;
import utils.DBContext;

public class UserDAO extends DBContext {

    // Các phương thức hiện có giữ nguyên
    public String hashMD5(String pass) {
        try {
            MessageDigest mes = MessageDigest.getInstance("MD5");
            byte[] mesMD5 = mes.digest(pass.getBytes());
            StringBuilder str = new StringBuilder();
            for (byte b : mesMD5) {
                String ch = String.format("%02x", b);
                str.append(ch);
            }
            return str.toString();
        } catch (Exception e) {
            System.out.println("Error in hashMD5: " + e.getMessage());
            return "";
        }
    }

    public boolean registerUser(Users user) {
        String sql = "INSERT INTO Users (RollNumber, Password, FullName, PhoneNumber, Address, Email, RoleID) VALUES (?, ?, ?, ?, ?, ?, 1)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getRollNumber());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getPhonenumber());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getEmail());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                String sqlNotification = "INSERT INTO NotificationSettings (RollNumber, NotificationInterval) VALUES (?, '24')";
                try (PreparedStatement psNotification = conn.prepareStatement(sqlNotification)) {
                    psNotification.setString(1, user.getRollNumber());
                    psNotification.executeUpdate();
                }
            }
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Register error: " + e.getMessage());
            return false;
        }
    }

    public Users verifyMD5(String rollNumber, String password) {
        String sql = "SELECT * FROM Users WHERE RollNumber = ? AND Password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, rollNumber);
            String hashedPassword = hashMD5(password);
            System.out.println("Verifying rollNumber: " + rollNumber + ", hashedPassword: " + hashedPassword);
            ps.setString(2, hashedPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Users(
                            rs.getInt("UserID"),
                            rs.getString("RollNumber"),
                            rs.getString("Password"),
                            rs.getString("FullName"),
                            rs.getString("PhoneNumber"),
                            rs.getString("Address"),
                            rs.getString("Email"),
                            rs.getInt("RoleID")
                    );
                } else {
                    System.out.println("No user found or password incorrect for rollNumber: " + rollNumber);
                }
            }
        } catch (SQLException e) {
            System.out.println("VerifyMD5 error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean isFullNameExists(String fullName) {
        String sql = "SELECT COUNT(*) FROM Users WHERE fullName = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fullName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("isFullNameExists error: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("isEmailExists error: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean changePassword(String rollNumber, String currentPassword, String newPassword) {
        String sqlCheck = "SELECT Password FROM Users WHERE RollNumber = ?";
        try {
            PreparedStatement psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, rollNumber);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("Password");
                    String hashedCurrentPassword = hashMD5(currentPassword);
                    System.out.println("Stored password: " + storedPassword);
                    System.out.println("Hashed current password: " + hashedCurrentPassword);
                    if (!storedPassword.equals(hashedCurrentPassword)) {
                        System.out.println("Current password does not match for rollNumber: " + rollNumber);
                        return false;
                    }
                } else {
                    System.out.println("User not found with rollNumber: " + rollNumber);
                    return false;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQLException in changePassword (SELECT): " + e.getMessage());
            e.printStackTrace();
            return false;
        }

        String sqlUpdate = "UPDATE Users SET Password = ? WHERE RollNumber = ?";
        try {
            PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
            String hashedNewPassword = hashMD5(newPassword);
            psUpdate.setString(1, hashedNewPassword);
            psUpdate.setString(2, rollNumber);
            System.out.println("Executing update: Password = " + hashedNewPassword + ", RollNumber = " + rollNumber);
            int rowsAffected = psUpdate.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQLException in changePassword (UPDATE): " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Phương thức cho cài đặt chung
    public int getDefaultLoanDays() {
        String sql = "SELECT DefaultLoanDays FROM LoanSettings";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("DefaultLoanDays");
            }
        } catch (SQLException e) {
            System.out.println("getDefaultLoanDays error: " + e.getMessage());
            e.printStackTrace();
        }
        return 14;
    }

    public int getLateDays(String rollNumber) {
        String sql = "SELECT SUM(DATEDIFF(day, DueDate, GETDATE())) as LateDays FROM Transactions WHERE RollNumber = ? AND DueDate < GETDATE() AND ReturnDate IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rollNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("LateDays");
                }
            }
        } catch (SQLException e) {
            System.out.println("getLateDays error: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getBookCount(String rollNumber) {
        String sql = "SELECT COUNT(*) as BookCount FROM Transactions WHERE RollNumber = ? AND ReturnDate IS NULL";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, rollNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("BookCount");
                }
            }
        } catch (SQLException e) {
            System.out.println("getBookCount error: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getMaxBooksAllowed() {
        String sql = "SELECT MaxBooksAllowed FROM LoanSettings";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("MaxBooksAllowed");
            }
        } catch (SQLException e) {
            System.out.println("getMaxBooksAllowed error: " + e.getMessage());
            e.printStackTrace();
        }
        return 10;
    }

    public int getLateFeePerDay() {
        String sql = "SELECT LateFeePerDay FROM LoanSettings";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("LateFeePerDay");
            }
        } catch (SQLException e) {
            System.out.println("getLateFeePerDay error: " + e.getMessage());
            e.printStackTrace();
        }
        return 15000;
    }

    public String getNotificationInterval(String rollNumber) {
        String sql = "SELECT NotificationInterval FROM NotificationSettings WHERE RollNumber = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rollNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("NotificationInterval");
                }
            }
        } catch (SQLException e) {
            System.out.println("getNotificationInterval error: " + e.getMessage());
            e.printStackTrace();
        }
        return "24";
    }

    public boolean updateNotificationInterval(String rollNumber, String interval) {
        String sql = "UPDATE NotificationSettings SET NotificationInterval = ? WHERE RollNumber = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, interval);
            ps.setString(2, rollNumber);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                String sqlInsert = "INSERT INTO NotificationSettings (RollNumber, NotificationInterval) VALUES (?, ?)";
                try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                    psInsert.setString(1, rollNumber);
                    psInsert.setString(2, interval);
                    return psInsert.executeUpdate() > 0;
                }
            }
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("updateNotificationInterval error: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean extendLoan(String rollNumber, int transactionId, int days, String reason) {
        String sql = "UPDATE Transactions SET ExtendedDays = ExtendedDays + ?, ExtensionReason = ? WHERE TransactionID = ? AND RollNumber = ? AND ReturnDate IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, days);
            ps.setString(2, reason);
            ps.setInt(3, transactionId);
            ps.setString(4, rollNumber);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("extendLoan error: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức mới để hỗ trợ ExtendLoanServlet
    public boolean extendLoanDays(String rollNumber, int extendDays) {
        String sql = "UPDATE Transactions SET DueDate = DATEADD(day, ?, DueDate) WHERE RollNumber = ? AND ReturnDate IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, extendDays);
            ps.setString(2, rollNumber);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("extendLoanDays error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}