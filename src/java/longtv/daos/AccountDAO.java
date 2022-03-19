/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import longtv.dtos.AccountDTO;
import longtv.util.DatabaseConnection;

/**
 *
 * @author Admin
 */
public class AccountDAO implements Serializable {

    Connection conn;
    PreparedStatement psm;
    ResultSet rs;

    private void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }

        if (psm != null) {
            psm.close();
        }

        if (conn != null) {
            conn.close();
        }
    }
    
    public boolean updatePassword(String newPassword, String username) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE AccountDetail SET Password = ? WHERE Username = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, newPassword);
            psm.setString(2, username);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean updateAccountInfo(AccountDTO account, String username) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE AccountInfo SET HomeNo = ?, District = ?, Gender = ?, DOB = ?, Email = ?, Image = ? "
                    + "WHERE Username = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, account.getHomeNumber());
            psm.setString(2, account.getDistrict());
            psm.setString(3, account.getGender());
            psm.setString(4, account.getDayOfBirth());
            psm.setString(5, account.getEmail());
            psm.setString(6, account.getImageLink());
            psm.setString(7, username);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkCorrectOTP(String otp, String phone) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT PhoneNumber "
                    + "FROM AccountSecurity "
                    + "WHERE PhoneNumber = ? AND OneTimeCode = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, phone);
            psm.setString(2, otp);
            rs = psm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkExistEmail(String email, String username) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT Username "
                    + "FROM AccountInfo "
                    + "WHERE Email = ? AND Username != ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, email);
            psm.setString(2, username);
            rs = psm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkExistPhone(String phone, String username) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT Username "
                    + "FROM AccountInfo "
                    + "WHERE PhoneNo = ? AND Username != ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, phone);
            psm.setString(2, username);
            rs = psm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkExistUsername(String username) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT Username "
                    + "FROM AccountDetail "
                    + "WHERE Username = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, username);
            rs = psm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updatePhoneSecurity(String phoneNo, String code) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE AccountSecurity SET OneTimeCode = ? WHERE PhoneNumber = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, code);
            psm.setString(2, phoneNo);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean insertPhoneSecurity(String phoneNo, String code) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO AccountSecurity(PhoneNumber, OneTimeCode) VALUES (?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, phoneNo);
            psm.setString(2, code);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkExistPhoneNumber(String phoneNo) throws Exception {
        try {
            String sql = "SELECT PhoneNumber\n"
                    + "FROM AccountSecurity\n"
                    + "WHERE PhoneNumber = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, phoneNo);
            rs = psm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }
    
    public AccountDTO getUserInfo(String username) throws Exception {
        AccountDTO dto = null;
        try {
            String sql = "SELECT D.Username, FullName, R.RoleName, I.PhoneNo, I.HomeNo, I.District, I.Email, I.Image, I.Gender, I.DOB\n"
                    + "FROM AccountDetail D JOIN AccountRole R\n"
                    + "ON D.IDRole = R.IDRole\n"
                    + "JOIN AccountInfo I\n"
                    + "ON D.Username = I.Username\n"
                    + "WHERE D.Username = ? AND Status = 1";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, username);
            rs = psm.executeQuery();
            if (rs.next()) {
                String userID = rs.getString("Username");
                String fullName = rs.getString("FullName");
                String roleName = rs.getString("RoleName");
                String phoneNo = rs.getString("PhoneNo");
                String homeNo = rs.getString("HomeNo");
                String district = rs.getString("District");
                String email = rs.getString("Email");
                String image = rs.getString("Image");
                String gender = rs.getString("Gender");
                String dob = rs.getString("DOB");
                dto = new AccountDTO(userID, fullName, roleName);
                dto.setPhoneNumber(phoneNo);
                dto.setHomeNumber(homeNo);
                dto.setDistrict(district);
                dto.setEmail(email);
                dto.setImageLink(image);
                dto.setDayOfBirth(dob);
                dto.setGender(gender);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public AccountDTO checkLogin(String username, String password) throws Exception {
        AccountDTO dto = null;
        try {
            String sql = "SELECT D.Username, FullName, R.RoleName, I.PhoneNo, I.HomeNo, I.District, I.Email, I.Image\n"
                    + "FROM AccountDetail D JOIN AccountRole R\n"
                    + "ON D.IDRole = R.IDRole\n"
                    + "JOIN AccountInfo I\n"
                    + "ON D.Username = I.Username\n"
                    + "WHERE D.Username = ? AND Password = ? AND Status = 1";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, username);
            psm.setString(2, password);
            rs = psm.executeQuery();
            if (rs.next()) {
                String userID = rs.getString("Username");
                String fullName = rs.getString("FullName");
                String roleName = rs.getString("RoleName");
                String phoneNo = rs.getString("PhoneNo");
                String homeNo = rs.getString("HomeNo");
                String district = rs.getString("District");
                String email = rs.getString("Email");
                String image = rs.getString("Image");
                dto = new AccountDTO(userID, fullName, roleName);
                dto.setPhoneNumber(phoneNo);
                dto.setHomeNumber(homeNo);
                dto.setDistrict(district);
                dto.setEmail(email);
                dto.setImageLink(image);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean insertAccountDetail(AccountDTO dto, int idRole) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO AccountDetail(Username, Password, FullName, Status, IDRole) VALUES(?,?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, dto.getUsername());
            psm.setString(2, dto.getPassword());
            psm.setString(3, dto.getFullname());
            psm.setInt(4, 1);
            psm.setInt(5, idRole);
            if(check = psm.executeUpdate() > 0) {
                check = insertAccountInfo(dto);
            }
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean insertAccountInfo(AccountDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO AccountInfo(Username, PhoneNo, Email, Image) VALUES(?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, dto.getUsername());
            psm.setString(2, dto.getPhoneNumber());
            psm.setString(3, dto.getEmail());
            psm.setString(4, dto.getImageLink());
            check = psm.executeUpdate() > 0; 
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkOldPassword(String username, String password) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT Username\n"
                    + "FROM AccountDetail\n"
                    + "WHERE Username = ? AND Password = ? AND Status = 1";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, username);
            psm.setString(2, password);
            rs = psm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

}
