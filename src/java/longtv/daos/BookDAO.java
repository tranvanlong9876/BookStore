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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import longtv.dtos.BookCartListDTO;
import longtv.dtos.CategoryBookDTO;
import longtv.dtos.CreateNewBookDTO;
import longtv.dtos.SearchBookDTO;
import longtv.util.DatabaseConnection;

/**
 *
 * @author Admin
 */
public class BookDAO implements Serializable {
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
    
    public List<SearchBookDTO> searchAllBooks(String search, int categoryID, String[] priceRange) throws Exception {
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat convertToVietNameseCurrency = NumberFormat.getCurrencyInstance(localeVN);
        List<SearchBookDTO> result = new ArrayList<>();
        SearchBookDTO dto;
        try {
            String sql = "SELECT BookID, Image, Title, Author, Price, Quantity, C.CategoryName\n"
                       + "FROM BookDetail B JOIN BookCategory C\n"
                       + "ON B.CategoryID = C.CategoryID\n"
                       + "WHERE Title LIKE ? AND B.CategoryID LIKE ? AND (Price BETWEEN ? AND ?) AND Status = 1 AND Quantity > 0";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, "%" + search + "%");
            psm.setString(2, "%" + (categoryID > 0 ? categoryID : "") + "%");
            psm.setString(3, priceRange[0]);
            psm.setString(4, priceRange[1]);
            rs = psm.executeQuery();
            while(rs.next()) {
                int bookID = rs.getInt("BookID");
                String image = rs.getString("Image");
                String title = rs.getString("Title");
                String author = rs.getString("Author");
                int quantity = rs.getInt("Quantity");
                float price = rs.getFloat("Price");
                String vietnamesePrice = convertToVietNameseCurrency.format(price);
                String categoryName = rs.getString("CategoryName");
                dto = new SearchBookDTO(image, title, author, categoryName, bookID, quantity, vietnamesePrice);
                result.add(dto);
            }
        } finally {
            
            closeConnection();
        }
        return result;
    }
    
    public SearchBookDTO getBookBasedOnID(String bookID) throws Exception {
        SearchBookDTO dto = null;
        try {
            String sql = "SELECT BookID, Image, Title, Author, Price, Quantity, Description, CategoryID\n"
                       + "FROM BookDetail\n"
                       + "WHERE BookID = ? AND Status = 1 AND Quantity > 0";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, bookID);
            rs = psm.executeQuery();
            if(rs.next()) {
                int id = rs.getInt("BookID");
                String image = rs.getString("Image");
                String title = rs.getString("Title");
                String author = rs.getString("Author");
                String price = rs.getString("Price");
                int quantity = rs.getInt("Quantity");
                int categoryID = rs.getInt("CategoryID");
                String description = rs.getString("Description");
                dto = new SearchBookDTO(image, title, author, id, quantity, price, description, categoryID);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public BookCartListDTO getBookBasedOnIDForAddToCart(String bookID) throws Exception {
        BookCartListDTO dto = null;
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat convertToVietNameseCurrency = NumberFormat.getCurrencyInstance(localeVN);
        try {
            String sql = "SELECT BookID, Image, Title, Author, Price\n"
                       + "FROM BookDetail\n"
                       + "WHERE BookID = ? AND Status = 1 AND Quantity > 0";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, bookID);
            rs = psm.executeQuery();
            if(rs.next()) {
                int id = rs.getInt("BookID");
                String image = rs.getString("Image");
                String title = rs.getString("Title");
                String author = rs.getString("Author");
                float price = rs.getFloat("Price");
                String vietnamesePrice = convertToVietNameseCurrency.format(price);
                dto = new BookCartListDTO(title, image, author, id, price);
                dto.setPriceCastToVietnameseCurrency(vietnamesePrice);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public List<CategoryBookDTO> loadAllBookCategories() throws Exception {
        List<CategoryBookDTO> result = new ArrayList<>();
        CategoryBookDTO dto;
        try {
            String sql = "SELECT CategoryID, CategoryName FROM BookCategory";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            rs = psm.executeQuery();
            while(rs.next()) {
                int categoryID = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");
                dto = new CategoryBookDTO(categoryID, categoryName);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public boolean checkExistedCategories(String categoryName) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT CategoryID\n" +
                         "FROM BookCategory\n" +
                         "WHERE CategoryName = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, categoryName);
            rs = psm.executeQuery();
            if(rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public int getIDValueAfterInsertNewCategory(String categoryName) throws Exception {
        int categoryID = 0;
        try {
            String sql = "INSERT INTO BookCategory(CategoryName)\n" +
                         "OUTPUT inserted.CategoryID\n" +
                         "VALUES (?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, categoryName);
            rs = psm.executeQuery();
            if(rs.next()) {
                categoryID = rs.getInt("CategoryID");
            }
        } finally {
            closeConnection();
        }
        return categoryID;
    }
    
    public boolean insertNewBook(CreateNewBookDTO dto) throws Exception {
        boolean check = false;
        Date date = new Date();
        Timestamp time = new Timestamp(date.getTime());
        try {
            String sql = "INSERT INTO BookDetail(Image, Title, Description, Author, Price, Quantity, CategoryID, Status, ImportDate)\n"
                       + "VALUES(?,?,?,?,?,?,?,?,?)";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, dto.getImage());
            psm.setString(2, dto.getTitle());
            psm.setString(3, dto.getDescription());
            psm.setString(4, dto.getAuthor());
            psm.setFloat(5, Float.parseFloat(dto.getPrice()));
            psm.setInt(6, Integer.parseInt(dto.getQuantity()));
            psm.setInt(7, dto.getCategoryID());
            psm.setInt(8, 1);
            psm.setTimestamp(9, time);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean updateSelectedBook(CreateNewBookDTO dto, int bookID) throws Exception {
        boolean check = false;
        Date date = new Date();
        Timestamp time = new Timestamp(date.getTime());
        try {
            String sql = "UPDATE BookDetail SET Image = ?, Title = ?, Description = ?, Author = ?, Price = ?, Quantity = ?, CategoryID = ?, ImportDate = ?\n"
                       + "WHERE BookID = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setString(1, dto.getImage());
            psm.setString(2, dto.getTitle());
            psm.setString(3, dto.getDescription());
            psm.setString(4, dto.getAuthor());
            psm.setFloat(5, Float.parseFloat(dto.getPrice()));
            psm.setInt(6, Integer.parseInt(dto.getQuantity()));
            psm.setInt(7, dto.getCategoryID());
            psm.setTimestamp(8, time);
            psm.setInt(9, bookID);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean deleteSelectedBook(int bookID) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE BookDetail SET Status = 0 WHERE BookID = ?";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setInt(1, bookID);
            check = psm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public int checkQuantityOfEachBook(int bookID) throws Exception {
        int quantity = 0;
        try {
            String sql = "SELECT Quantity\n"
                       + "FROM BookDetail\n"
                       + "WHERE BookID = ? AND Status = 1 AND Quantity > 0";
            conn = DatabaseConnection.makeConnection();
            psm = conn.prepareStatement(sql);
            psm.setInt(1, bookID);
            rs = psm.executeQuery();
            if(rs.next()) {
                quantity = rs.getInt("Quantity");
            }
        } finally {
            closeConnection();
        }
        return quantity;
    }
}
