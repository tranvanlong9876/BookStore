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
        if(rs != null) {
            rs.close();
        }
        
        if(psm != null) {
            psm.close();
        }
        
        if(conn != null) {
            conn.close();
        }
    }
    
    public AccountDTO checkLogin(String username, String password) throws Exception {
        AccountDTO dto = null;
        try {
            String sql = "SELECT Username, FullName, R.RoleName\n"
                       + "FROM AccountDetail D JOIN AccountRole R\n"
                       + "ON D.IDRole = R.IDRole\n"
                       + "WHERE Username = ? AND Password = ? AND Status = 1";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, username);
            psm.setString(2, password);
            rs = psm.executeQuery();
            if(rs.next()) {
                String userID = rs.getString("Username");
                String fullName = rs.getString("FullName");
                String roleName = rs.getString("RoleName");
                dto = new AccountDTO(userID, fullName, roleName);
            }
        } finally {
            closeConnection();
        }
        return dto;
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
            if(rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }
    
}
