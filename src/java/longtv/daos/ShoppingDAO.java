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
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import longtv.dtos.BookCartListDTO;
import longtv.dtos.HistoryHeaderDTO;
import longtv.dtos.OrderHeaderDTO;
import longtv.util.DatabaseConnection;

/**
 *
 * @author Admin
 */
public class ShoppingDAO implements Serializable {

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

    public boolean checkQuantities(int bookID, int quantity) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT BookID\n"
                    + "FROM BookDetail\n"
                    + "WHERE BookID = ? AND Quantity >= ? AND Status = 1";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setInt(1, bookID);
            psm.setInt(2, quantity);
            rs = psm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public int minusQuantity(int bookID, int quantity) throws Exception {
        int leftQuantity = -1;
        try {
            String sql = "UPDATE BookDetail\n"
                    + "SET Quantity = (SELECT Quantity FROM BookDetail\n"
                    + "WHERE BookID = ?) - ?\n"
                    + "OUTPUT inserted.Quantity\n"
                    + "WHERE BookID = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setInt(1, bookID);
            psm.setInt(2, quantity);
            psm.setInt(3, bookID);
            rs = psm.executeQuery();
            if (rs.next()) {
                leftQuantity = rs.getInt("Quantity");
            }
        } finally {
            closeConnection();
        }
        return leftQuantity;
    }
    
    public void restoreQuantity(int bookID, int quantity) throws Exception {
        try {
            String sql = "UPDATE BookDetail\n"
                    + "SET Quantity = (SELECT Quantity FROM BookDetail\n"
                    + "WHERE BookID = ?) + ?\n"
                    + "WHERE BookID = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setInt(1, bookID);
            psm.setInt(2, quantity);
            psm.setInt(3, bookID);
        } finally {
            closeConnection();
        }
    }

    public boolean insertOrderHeader(OrderHeaderDTO dto, Timestamp time) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO OrderHeader(OrderID, Username, OrderTime, Status, TotalPrice, DiscountCode, PaymentType, PaymentID, PaidAccount, PaidAmoundPaypal, DeliveryAddress)\n"
                       + "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, dto.getOrderID());
            psm.setString(2, dto.getUsername());
            psm.setTimestamp(3, time);
            psm.setInt(4, dto.getStatus());
            psm.setFloat(5, dto.getTotalPrice());
            psm.setString(6, dto.getVoucherApplied());
            psm.setInt(7, dto.getPaymentType());
            psm.setString(8, dto.getPaymentID());
            psm.setString(9, dto.getPaidAccountPaypal());
            psm.setString(10, dto.getAmountPaypal());
            psm.setString(11, dto.getDeliveryAddress());
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean insertOrderDetail(BookCartListDTO dto, String orderID) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO OrderDetail(OrderID, BookID, Quantity, PriceEachBook, PriceTotalBook)\n"
                       + "VALUES(?,?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, orderID);
            psm.setInt(2, dto.getBookID());
            psm.setInt(3, dto.getBookQuantity());
            psm.setFloat(4, dto.getBookPrice());
            psm.setFloat(5, dto.getBookPrice() * dto.getBookQuantity());
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean refundUserCheckOut(String accountPaypal, String paypalID, String amoundRefund) throws Exception {
        boolean check = false;
        try {
            Timestamp time = new Timestamp(new Date().getTime());
            String sql = "INSERT INTO Refund(PaymentID, PaidAccount, PaidAmoundPaypal, TimeOccur, Status)\n"
                       + "VALUES(?,?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, paypalID);
            psm.setString(2, accountPaypal);
            psm.setString(3, amoundRefund);
            psm.setTimestamp(4, time);
            psm.setInt(5, 0);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public void inactiveVoucher(String voucherCode) throws Exception {
        try {
            String sql = "UPDATE Discount SET Status = 0\n"
                       + "WHERE DiscountCode = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, voucherCode);
            psm.executeUpdate();
        } finally {
            closeConnection();
        }
    }
    
    public List<HistoryHeaderDTO> loadHistoryHeaderUserRole(String username, String date) throws Exception {
        List<HistoryHeaderDTO> historyList = new ArrayList<>();
        HistoryHeaderDTO dto;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-YYYY HH:mm:ss");
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat convertToVND = NumberFormat.getCurrencyInstance(localeVN);
        try {
            String sql = "SELECT OrderID, A.FullName, A.Username, TotalPrice, DiscountCode, S.StatusName, P.PaymentName, OrderTime\n" +
                         "FROM OrderHeader O JOIN AccountDetail A\n" +
                         "ON O.Username = A.Username\n" +
                         "JOIN OrderStatus S\n" +
                         "ON O.Status = S.StatusID\n" +
                         "JOIN PaymentMethod P\n" +
                         "ON O.PaymentType = P.PaymentID\n" +
                         "WHERE A.Username = ? AND (CONVERT(nvarchar, OrderTime, 23) LIKE ?)\n" +
                         "ORDER BY OrderTime DESC";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, username);
            psm.setString(2, "%" + date + "%");
            rs = psm.executeQuery();
            while(rs.next()) {
                String orderID = rs.getString("OrderID");
                String fullName = rs.getString("FullName");
                float totalPrice = rs.getFloat("TotalPrice");
                String priceVND = convertToVND.format(totalPrice);
                String discountCode = rs.getString("DiscountCode");
                String status = rs.getString("StatusName");
                String paymentType = rs.getString("PaymentName");
                String orderTime = sdf.format(rs.getTimestamp("OrderTime"));
                dto = new HistoryHeaderDTO(orderID, fullName, priceVND, discountCode, status, paymentType, orderTime);
                historyList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return historyList;
    }
    
    public List<HistoryHeaderDTO> loadHistoryHeaderAdminRole(String date) throws Exception {
        List<HistoryHeaderDTO> historyList = new ArrayList<>();
        HistoryHeaderDTO dto;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-YYYY HH:mm:ss");
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat convertToVND = NumberFormat.getCurrencyInstance(localeVN);
        try {
            String sql = "SELECT OrderID, A.FullName, A.Username, TotalPrice, DiscountCode, S.StatusName, P.PaymentName, OrderTime\n" +
                         "FROM OrderHeader O JOIN AccountDetail A\n" +
                         "ON O.Username = A.Username\n" +
                         "JOIN OrderStatus S\n" +
                         "ON O.Status = S.StatusID\n" +
                         "JOIN PaymentMethod P\n" +
                         "ON O.PaymentType = P.PaymentID\n" +
                         "WHERE (CONVERT(nvarchar, OrderTime, 23) LIKE ?)\n" +
                         "ORDER BY OrderTime DESC";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, "%" + date + "%");
            rs = psm.executeQuery();
            while(rs.next()) {
                String orderID = rs.getString("OrderID");
                String fullName = rs.getString("FullName");
                String username = rs.getString("Username");
                float totalPrice = rs.getFloat("TotalPrice");
                String priceVND = convertToVND.format(totalPrice);
                String discountCode = rs.getString("DiscountCode");
                String status = rs.getString("StatusName");
                String paymentType = rs.getString("PaymentName");
                String orderTime = sdf.format(rs.getTimestamp("OrderTime"));
                dto = new HistoryHeaderDTO(orderID, fullName, username, priceVND, discountCode, status, paymentType, orderTime);
                historyList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return historyList;
    }
    
    public HistoryHeaderDTO getOrderHeaderWithOrderID(String orderID) throws Exception {
        HistoryHeaderDTO dto = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-YYYY HH:mm:ss");
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat convertToVND = NumberFormat.getCurrencyInstance(localeVN);
        try {
            String sql = "SELECT A.FullName, A.Username, TotalPrice, DiscountCode, S.StatusName, P.PaymentName, OrderTime, O.PaymentID, PaidAccount, PaidAmoundPaypal, DeliveryAddress\n" +
                         "FROM OrderHeader O JOIN AccountDetail A\n" +
                         "ON O.Username = A.Username\n" +
                         "JOIN OrderStatus S\n" +
                         "ON O.Status = S.StatusID\n" +
                         "JOIN PaymentMethod P\n" +
                         "ON O.PaymentType = P.PaymentID\n" +
                         "WHERE OrderID = ?\n";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, orderID);
            rs = psm.executeQuery();
            if(rs.next()) {
                String fullName = rs.getString("FullName");
                String username = rs.getString("Username");
                float totalPrice = rs.getFloat("TotalPrice");
                String priceVND = convertToVND.format(totalPrice);
                String discountCode = rs.getString("DiscountCode");
                String status = rs.getString("StatusName");
                String paymentType = rs.getString("PaymentName");
                String orderTime = sdf.format(rs.getTimestamp("OrderTime"));
                dto = new HistoryHeaderDTO(orderID, fullName, username, priceVND, discountCode, status, paymentType, orderTime);
                dto.setPaypalAccount(rs.getString("PaidAccount"));
                dto.setPaymentPaypalID(rs.getString("PaymentID"));
                dto.setPayAmountDollar(rs.getString("PaidAmoundPaypal"));
                dto.setDeliveryAddress(rs.getString("DeliveryAddress"));
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public List<BookCartListDTO> loadHistoryDetail(String orderID) throws Exception {
        List<BookCartListDTO> detailOfList = new ArrayList<>();
        BookCartListDTO dto;
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat convertToVND = NumberFormat.getCurrencyInstance(localeVN);
        try {
            String sql = "SELECT Image, Title, Author, PriceEachBook, PriceTotalBook, D.Quantity\n" +
                         "FROM OrderDetail D JOIN BookDetail B\n" +
                         "ON D.BookID = B.BookID\n" +
                         "WHERE OrderID = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, orderID);
            rs = psm.executeQuery();
            while(rs.next()) {
                String image = rs.getString("Image");
                String title = rs.getString("Title");
                String author = rs.getString("Author");
                String priceEachBook = convertToVND.format(rs.getFloat("PriceEachBook"));
                String priceTotalBook = convertToVND.format(rs.getFloat("PriceTotalBook"));
                int bookedQuantity = rs.getInt("Quantity");
                dto = new BookCartListDTO(title, image, author, bookedQuantity, priceEachBook, priceTotalBook);
                dto.setBookPrice(rs.getFloat("PriceEachBook"));
                detailOfList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return detailOfList;
    }
}
