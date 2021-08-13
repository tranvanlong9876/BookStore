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
import java.sql.Timestamp;
import java.util.Date;
import longtv.dtos.VoucherDTO;
import longtv.util.DatabaseConnection;

/**
 *
 * @author Admin
 */
public class VoucherDAO implements Serializable {
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
    
    public boolean checkExistVoucher(String voucherCode) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT DiscountCode FROM Discount WHERE DiscountCode = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, voucherCode);
            rs = psm.executeQuery();
            if(rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public int getDiscountPercent(String voucherCode) throws Exception {
        try {
            String sql = "SELECT DiscountPercent\n" +
                         "FROM Discount\n" +
                         "WHERE DiscountCode = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, voucherCode);
            rs = psm.executeQuery();
            if(rs.next()) {
                return rs.getInt("DiscountPercent");
            }
        } finally {
            closeConnection();
        }
        return 0;
    }
    
    public VoucherDTO applyVoucherDetail(String voucherCode) throws Exception {
        VoucherDTO dto = null;
        Date date = new Date();
        Timestamp time = new Timestamp(date.getTime());
        try {
            String sql = "SELECT DiscountCode, DiscountPercent, DiscountDescription\n" +
                         "FROM Discount\n" +
                         "WHERE DiscountCode = ? AND (? BETWEEN CreateDate AND ExpireDate) AND Status = 1";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, voucherCode);
            psm.setTimestamp(2, time);
            rs = psm.executeQuery();
            if(rs.next()) {
                String discountCode = rs.getString("DiscountCode");
                String discountPercent = rs.getString("DiscountPercent");
                String discountDesc = rs.getString("DiscountDescription");
                dto = new VoucherDTO(discountCode, discountDesc, discountPercent);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean createNewVoucher(VoucherDTO dto, Timestamp createDate, Timestamp expireDate) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO Discount(DiscountCode, DiscountPercent, DiscountDescription, CreateDate, ExpireDate, Status)\n"
                       + "VALUES(?,?,?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, dto.getDiscountCode());
            psm.setInt(2, Integer.parseInt(dto.getDiscountPercent()));
            psm.setString(3, dto.getDiscountDesc());
            psm.setTimestamp(4, createDate);
            psm.setTimestamp(5, expireDate);
            psm.setInt(6, 1);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
}
